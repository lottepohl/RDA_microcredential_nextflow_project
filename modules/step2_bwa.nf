#!/usr/bin/env nextflow

process bwa_process{
    container 'quay.io/biocontainers/bwa:0.7.19--h577a1d6_1'
    // container 'community.wave.seqera.io/library/bwa_htslib_samtools:83b50ff84ead50d0'
    // container 'https://hub.docker.com/r/shinejh0528/bbmerge'
    
    publishDir "${params.outdir}/bwa/", mode: 'copy', overwrite: true
    tag "$sample"

    input:
    tuple path(genes), path(borders)
    tuple val(sample), path(merged_read)

    output:
    path("${sample}.sam"), emit: sam

    script:
    """
    bwa index $genes
    bwa mem $genes $merged_read > ${sample}.sam
    """

}