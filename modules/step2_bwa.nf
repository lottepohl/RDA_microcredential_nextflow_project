// from the small project inside the nextflow course: just placeholder
process bwa{
    container 'quay.io/biocontainers/bwa:0.7.19--h577a1d6_1'
    publishDir {"${params.outdir}/fastqc/fastqc-${sample}/"}, mode: 'copy', overwrite: true

    tag "$sample" // show var during pipeline execution

    input:
    tuple val(sample), path(read1), path(read2)

    output:
    path("*_bwa.{zip,html}"), emit: bwa

    script:
    """
    bwa ${sample}
    """

}