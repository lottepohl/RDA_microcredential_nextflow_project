#!/usr/bin/env nextflow

// include modules
include { flash2_process } from "./modules/step1_flash2"
include { bwa_process } from "./modules/step2_bwa"

// define parameters
params {
//     samples_path = "${launchDir}/data_raw"
samples_path = "/data/gent/courses/2025/vibrepdata_EXT003/shared/testdata_lotte_and_matilde"
ref_path = "${launchDir}/genome_reference"
outdir = "${launchDir}/results"
}



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

    def reference_ch = channel
        .of(
            file("${params.ref_path}/reference_genes.fasta"),
            file("${params.ref_path}/borderFile.gff")
        )

    // execute bwa on the output of flash2
    bwa_process(reference_ch, flash2_process.out.merged)

}