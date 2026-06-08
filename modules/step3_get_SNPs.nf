// from the small project inside the nextflow course: just placeholder
// will be using the custom .py script container!
process fastqc_proj{
    // container 'biocontainers/fastqc:v0.11.9_cv8'
    container 'quay.io/biocontainers/fastqc:0.11.9--0'
    publishDir {"${params.outdir}/fastqc/fastqc-${sample}/"}, mode: 'copy', overwrite: true

    tag "$sample" // show var during pipeline execution

    input:
    tuple val(sample), path(fastq_1), path(fastq_2)

    output:
    path("*_fastqc.{zip,html}"), emit: fastqc

    script:
    """
    fastqc ${sample}
    """

}