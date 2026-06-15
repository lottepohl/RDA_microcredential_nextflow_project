#!/usr/bin/env nextflow

   // stage .sif files to scratch
    // def scratchImages = "${System.getenv('VSC_SCRATCH')}/images"
    // new File(scratchImages).mkdirs()

    // new File("${projectDir}/images").eachFile { f ->
    //     if (f.name.endsWith('.sif')) {
    //         def dest = new File("${scratchImages}/${f.name}")
    //         if (!dest.exists()) {
    //             dest.bytes = f.bytes
    //         }
    //     }
    // }
    // continue here! we need to find a solution to copy the .sif files into VSC_SCRATCH - potentially make its own module!

// define parameters

params {
//     samples_path = "${launchDir}/data_raw"
samples_path = "/data/gent/courses/2025/vibrepdata_EXT003/shared/testdata_lotte_and_matilde"
images_path = scratchImages
// images_path = "/data/gent/courses/2025/vibrepdata_EXT003/shared/images_lotte_and_matilde"
ref_path = "${launchDir}/genome_reference"
outdir = "${launchDir}/results"
}

// include modules
include { flash2_process } from "./modules/step1_flash2"
include { bwa_process } from "./modules/step2_bwa"

workflow {

    // make the data into an input channel for the FLASH
    samples_ch = channel
        .fromPath("${params.samples_path}/samplesinfo.csv")
        .splitCsv(header: false)
        .map { row ->
            def sample_id = row[0]

            tuple(
                sample_id,
                file("${params.samples_path}/${sample_id}_1.fq.gz"),
                file("${params.samples_path}/${sample_id}_2.fq.gz")
            )
        }
        .view()

    // execute flash2
    flash2_process(samples_ch)

//     def reference_ch = channel
//         .of(
//             file("${params.ref_path}/reference_genes.fasta"),
//             file("${params.ref_path}/borderFile.gff")
//         )

//     // execute bwa on the output of flash2
//     bwa_process(reference_ch, flash2_process.out.merged)

 }