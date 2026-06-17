#!/usr/bin/env nextflow


process sam_to_bam{
    container "docker://quay.io/biocontainers/samtools:1.17--h00cdaf9_0"

    publishDir "results/mapping/", mode: 'copy', overwrite: true
    tag "$sample"

    input:
    path sample

    output:
    path "${sample}.bam", emit: bam

    script:
    """
    samtools sort -o ${sample}.bam ${sample}
    """
}
