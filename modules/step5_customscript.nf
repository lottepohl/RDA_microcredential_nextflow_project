#!/usr/bin/env nextflow

process haplotype_analysis {

    input:
    tuple path(haplo_file),
          path(reference),
          path(borders),
          path(samplesinfo)

    output:
    path "plots/*"

    script:
    """
    python3 HaplotypeAnalysis.py \
        --haplotypes $haplo_file \
        --reference $reference \
        --borders $borders \
        --samples $samplesinfo \
        > *.png
    """
}
