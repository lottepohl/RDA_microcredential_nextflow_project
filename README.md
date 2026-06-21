# RDA_microcredential_nextflow_project
repository to store code for the nextflow project in the context of the VIB reproducible data analysis microcredential, Q2 2026

*Authors*: Matilde Sanches (VIB), Lotte Pohl (UGent)

## Description of the pipeline

The pipeline of this microcredential nextflow project uses DNA-reads of maize fastq-files as raw input data.
The goal is to identify the number of Single Nucleotide Polymorphisms (SNPs) in the sequencing data.
The main result after running the pipeline is a plot visualising the share SNP share inside the `results/` folder.

The pipeline encompasses these main steps:
    
    1. The tool [bbmerch](https://hub.docker.com/layers/shinejh0528/bbmerge/1.0.0/images/sha256-8fd086c6f5cf0425584c9cd93a632e94ce055eb3ad0334c7873c135311b02ef1) [Bushner et al., 2017](https://doi.org/10.1371/journal.pone.0185056) is implemented to match pairs of DNA strands

    3. After the matching is completed, the [Burrows-Wheeler Aligner (bwa)](https://hub.docker.com/layers/biocontainers/bwa/v0.7.17_cv1/images/sha256-9479b73e108ded3c12cb88bb4e918a5bf720d7861d6d8cdbb46d78a972b6ff1b) is used to create indices and to map to a reference genome.

    4. After aligning, a custom .py script is run to get from DNA reads to counts of base pairs, and from that to the number of mutations (the SNPs). The script makes an overview plot of the number of SNPs identified from the input data.

    The custom .py script is inside a container, which can be found here: (* insert link *).

    The dockerhub images are put on the shared folder on the UGent hpc: /data/gent/courses/2025/vibrepdata_EXT003/shared/testdata_lotte_and_matilde

## Instructions how to run the pipeline 

### Test dataset

- maize .fastq files

biocontainers tools used. Biocontainers info: https://biocontainers-edu.readthedocs.io/en/latest/examples.html, https://biocontainers.pro/registry 

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

The input files are in the `genome_reference` directory. The 

## Output files

In the  `results` directory, a plot of the share of SNPs found in the test sample will be saved.

## Contribution

* M, with assistance of L drafted the project idea. M had some test data and a custom script from another project which served as the basis for the developed workflow.

* L drafted the first version of the `README.md`, which was then completed by M with additional, more bioinformatic-specific information.

* L setup the folder structure and created a github repository.

* L drafted a first version of the three original modules (`step1_flah2.nf`, `step2_bwa.nf`, `step5_customscript.nf`). 

* M provided and prepared the input data (in folder `./genome_reference/`)

* M finalised the three initial modules, and during this work realised the need for two additional modules (`step3_samtools.nf`, `step4_smap.nf`) which she drafted and completed.

* L drafted the `main.nf` workflow, which M completed during and after the completion of the modules.

* M and L worked in collaboration on providing the apptainer images on the VSC environment. Because of the security issues, the .sif files could not be pulled on the VSC itself but needed to be provided on an agreed shared location. M identified the images that needed to be pulled, L pulled them on her local laptop and copied the .sif files to the VSC.

* L was in E-Mail contact with the VIB trainers.

* M amended the custom python script she had worked on in another project to serve the purpose of this nextflow project. She containerised it and provided the resulting image on dockerhub. *[...]*

* L made a profile in `nextflow.config` *(not there anymore at the moment, I might need to push from the VSC...)*.

* L drafted the contributions section, M completed it.
