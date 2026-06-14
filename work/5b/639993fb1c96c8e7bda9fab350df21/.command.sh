#!/bin/bash -ue
// flash2 null_1.fq null_2.fq -o null -t 1
bbmerge null_1.fq null_2.fq -o null

gzip null.extendedFrags.fastq null*.notCombined*.fastq
gzip null.merged.fq null.unmerged.fq
