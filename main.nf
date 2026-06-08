#!/usr/bin/env nextflow

// main workflow for the small RDA nextflow project: https://liascript.github.io/course/?https://raw.githubusercontent.com/vibbits/nextflow-workshop/main/README.md#67
//Set up a main.nf script in which you will build your pipeline which reads in the forward and reverse reads for each of the five samples in the data1-directory into a channel.

//containers
// The following docker containers will work well with Nextflow for the pipeline you're going to create:
// fastqc: biocontainers/fastqc:v0.11.9_cv8
// multiqc: multiqc/multiqc:v1.25.1
// DADA2: blekhmanlab/dada2:1.26.0
// Python: python:slim-bullseye
// Fastp: quay.io/biocontainers/fastp:1.0.1--heae3180_0
// MultiQC is a tool to summarize quality control metrics coming from different tools for multiple samples. E.g. this is used to create a summary of all quality control metrics determined by FastQ for all samples in the pipeline run.
// DADA2 is a tool to identify and quantify the microorganisms present from (amplicon) sequencing data.
// Fastp is an alternative of Trimmomatic for trimming FASTQ reads.

// include modiles
include { flash2} from "./modules/step1_flash2" 
include { bwa } from "./modules/step2_bwa" 

// define parameters
params {
    data_path: String="${launchDir}/project/data1/*.fastq" // if file pattern: put String, not Path!
    samples_path: Path="/data/gent/courses/2025/vibrepdata_EXT003/shared/testdata_lotte_and_matilde"
    outdir: Path="${launchDir}/results"
}

workflow {
    // make the data into an input channel for the fastqc
    def samples_ch = channel
    .of('sample1', 'sample2', 'sample3', 'control1')
    .map { sample ->
        tuple(
            sample,
            file("${params.sample_path}/${sample}_1.fq"),
            file("${params.sample_path}/${sample}_2.fq")
        )
    }
    .view()

    // execute flash2
    flash2(samples_ch)

    // Stopped on 2026-06-08
    
    // // execute the fastqc
    // fastqc_proj(samples_ch)

    // //define the input for the multiqc and get it all in 1 list
    // input_multiqc = fastqc_proj.out.fastqc
    //                 .collect()
    //                 .view()

    // // execute the multiqc on the list of fastwc files
    // // multiqc_proj(input_multiqc)
}

