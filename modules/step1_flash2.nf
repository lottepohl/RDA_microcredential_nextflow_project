// flash container: https://quay.io/repository/biocontainers/flash?tab=info
process flash2 {
    container 'quay.io/biocontainers/flash2:2.2.00--h577a1d6_9'
    publishDir "${params.outdir}/flash2/flash-${sample}/", mode: 'copy', overwrite: true
    tag "$sample" // show var during pipeline execution

    input:
    tuple val(sample), path(read1), path(read2)

    output:
    tuple val(sample), path("*.extendedFrags.fastq"), emit: merged
    tuple val(sample), path("*.notCombined*.fastq"),  emit: unmerged

    script:
    """
    flash2 ${read1} ${read2} -o ${sample} -t ${task.cpus}
    """
}
