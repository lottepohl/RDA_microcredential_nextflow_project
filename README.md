# RDA_microcredential_nextflow_project
repository to store code for the nextflow project in the context of the VIB reproducible data analysis microcredential, Q2 2026

*Authors*: Matilde Sanches (VIB), Lotte Pohl (UGent)

## Description of the pipeline

The pipeline of this microcredential nextflow project uses DNA-reads of maize fastq-files as raw input data.
The goal is to identify the number of Single Nucleotide Polymorphisms (SNPs) in the sequencing data.
The main result after running the pipeline is a plot visualising the share SNP share inside the `results/` folder.

The pipeline encompasses four main steps:

    1. The tool [bbmerch](https://hub.docker.com/layers/shinejh0528/bbmerge/1.0.0/images/sha256-8fd086c6f5cf0425584c9cd93a632e94ce055eb3ad0334c7873c135311b02ef1) [Bushner et al., 2017](https://doi.org/10.1371/journal.pone.0185056) is implemented to match pairs of DNA strands

    3. After the matching is completed, the [Burrows-Wheeler Aligner (bwa)](https://hub.docker.com/layers/biocontainers/bwa/v0.7.17_cv1/images/sha256-9479b73e108ded3c12cb88bb4e918a5bf720d7861d6d8cdbb46d78a972b6ff1b) is used to create indices and to map to a reference genome.

    4. After aligning, a custom .py script is run to get from DNA reads to counts of base pairs, and from that to the number of mutations (the SNPs). The script makes an overview plot of the number of SNPs identified from the input data.

    The custom .py script is inside a container, which can be found here: (* insert link *).

    The dockerhub images are put on the shared folder on the UGent hpc: /data/gent/courses/2025/vibrepdata_EXT003/shared/apptainer_cache

## Instructions how to run the pipeline 

### Test dataset

### Setup for the HPC:

Copy the following lines of code in your terminal of the HPC
```
module load Nextflow/26.04.3

export APPTAINER_CACHEDIR=${VSC_SCRATCH}/.apptainer_cache

export APPTAINER_TMPDIR=${VSC_SCRATCH}/.apptainer_tmp

```
When you set up your HPC instance to use nextflow for the first time, copy these 2 setup lines of code in your terminal too:
```
mkdir ${VSC_SCRATCH}/.apptainer_cache
mkdir ${VSC_SCRATCH}/.apptainer_tmp
```

## Input files

## Output files