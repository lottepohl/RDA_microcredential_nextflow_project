#!/usr/bin/env nextflow


process smap_haplotype_window {
    // container 'docker://ilvo/smap:latest'
    container 'smap_hapwindow.sif'

    publishDir "results/hapcount/", mode: 'copy', overwrite: true

    input:
    tuple path (reference_fasta), path (borders_gff), path (mapped_bam), path (merged_fq)

    output:
    path "haplotype_counts.tsv", emit: smap_counts
    path "haplotype_frequencies.tsv", emit: smap_freqs

    script:
    """
    smap haplotype-window ${reference_fasta} ${borders_gff} ${mapped_bam} ${merged_fq} -f 2 -c 50 -m 1
    """
}
