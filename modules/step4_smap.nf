#!/usr/bin/env nextflow


process smap_haplotype_window {
    container 'docker://ilvo/smap:latest'

    publishDir "results/hapcount/", mode: 'copy', overwrite: true
    tag "${sample_id}"


    input:
    path (reference_fasta)
    path (borders_gff)
    path (mapped_bam)
    path (merged_fq)
    val (sample_id)

    output:
    path "haplotype_counts_c50_f2_m1.tsv", emit: smap_counts
    path "haplotype_frequencies_c50_f2_m1.tsv", emit: smap_freqs

    script:
    """
    smap haplotype-window ${reference_fasta} ${borders_gff} ${mapped_bam} ${merged_fq} -f 2 -c 50 -m 1
    """
}
