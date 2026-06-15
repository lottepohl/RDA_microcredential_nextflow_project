#!/usr/bin/env nextflow

// flash container: https://quay.io/repository/biocontainers/flash?tab=info
process flash2_process {
    container "${params.images_path}/flash2.sif"
    //container 'quay.io/biocontainers/flash2:2.2.00--h577a1d6_9'
    // container "docker-archive:///scratch/gent/516/vsc51676/flash2.tar"
    
    publishDir "${params.outdir}/flash2/", mode: 'copy', overwrite: true
    tag "$sample"

    input:
    tuple val(sample), path(read1), path(read2)

    output:
    tuple val(sample), path("${sample}.extendedFrags.fastq.gz"), emit: merged
    path("${sample}_1.notCombined.fastq.gz")
    path("${sample}_2.notCombined.fastq.gz")

    script:
    """
    flash2 $read1 $read2 -o $sample -t $task.cpus
    gzip ${sample}.extendedFrags.fastq ${sample}*.notCombined*.fastq
    """
}