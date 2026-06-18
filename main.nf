#!/usr/bin/env nextflow

// define parameters
params {
    samples_path = "/data/gent/courses/2025/vibrepdata_EXT003/shared/testdata_lotte_and_matilde"

    // ref_path = "${launchDir}/genome_reference"
    ref_path = "./genome_reference/originalref"
    // ref_path = "./genome_reference/newref"

    // outdir = "${launchDir}/results"

}

// include modules
// include { copy_images } from "./modules/step0_copy_images"
include { flash2_process } from "./modules/step1_flash2"
include { bwa_index ; bwa_mapping } from "./modules/step2_bwa"
include { sam_to_bam } from "./modules/step3_samtools"
include { smap_haplotype_window } from "./modules/step4_smap"
// include { haplotype_analysis } from "./modules/step5_customscript"


workflow {   
    // make the paired end reads data into an input channel for the FLASH
    def samples_ch = channel
        .fromPath("${params.samples_path}/samplesinfo.csv")
        .splitCsv(header: false)
        .map { row ->
            def sample_id = row[0]
            tuple(sample_id,
                file("${params.samples_path}/${sample_id}_1.fq.gz"),
                file("${params.samples_path}/${sample_id}_2.fq.gz"))
        }
        .view()
    
    // execute flash2
    flash2_process(samples_ch)

    // make a channel for the files necessary for BWA to make an index
    def reference_ch = channel
        .of(file("${params.ref_path}/originalref/reference_genes.fasta"))
    // def reference_ch = channel
    // .of(file("${params.ref_path}/newref/GCA_902167145-chromosomes.fasta"))

    // make a channel for the border file of polymorphic regions necessary for SMAP
    def borders_ch = channel
        .of(file("${params.ref_path}/originalref/borderFile.gff"))
    // def reference_ch = channel
    // .of(file("${params.ref_path}/newref/border10Targets.gff"))


    // create index from reference genes
    bwa_index(reference_ch)
    // execute bwa on the output of flash2
    bwa_mapping(flash2_process.out.merged
        .combine(bwa_index.out.index))
    // convert the sam files to bam files
    sam_to_bam(bwa_mapping.out.sam)


    // // prepare pairs of flash2 and samtobam outputs per sample, to input in SMAP
    // def pairs_reads_and_mappings_ch = sam_to_bam.out.bam
    //     .join(flash2_process.out.merged)

    // // we need the reference and the borders to be combined with each sample's reads&mapping pair
    // def smap_input_ch = pairs_reads_and_mappings_ch
    //     .combine(reference_ch)
    //     .combine(borders_ch)
    //     .map {reference, borders, bam, merged ->
    //         tuple(reference, borders, bam, merged)
    //     }
 

    // // distinguish haplotypes at each polymorphic locus with SMAP
    // smap_haplotype_window(smap_input_ch)


 }