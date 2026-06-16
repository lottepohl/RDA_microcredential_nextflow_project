#!/usr/bin/env nextflow

// stage .sif files to scratch
// def scratchImages = "${System.getenv('VSC_SCRATCH')}/images"
// new File(scratchImages).mkdirs()

// new File("${projectDir}/images").eachFile { f ->
//     if (f.name.endsWith('.sif')) {
//         def dest = new File("${scratchImages}/${f.name}")
//         if (!dest.exists()) {
//             dest.bytes = f.bytes
//         }
//     }
// }
// continue here! we need to find a solution to copy the .sif files into VSC_SCRATCH - potentially make its own module!


// Lotte, the .sif files you built are now copied to the shared folder!! :) 
// You're right that they need to be in the $VSC_SCRATCH/.apptainer_cache, BECAUSE THE APPTAINER TRIES TO RUN THE IMAGE FROM THERE (and not from the internet) 
// // Why this? Because we defined it to when we initialized the whole thing... ----> export APPTAINER_CACHEDIR=${VSC_SCRATCH}/.apptainer_cache
// Therefore, when we start to work, we must always indeed copy the images from the shared folder into our SCRATCH/.apptainer_cache ----> cp /data/gent/courses/2025/vibrepdata_EXT003/shared/apptainer_cache/* $VSC_SCRATCH/.apptainer_cache/ 
// // Of course, internally for us we could also copy them from the images folder you made inside the project... ----> cp RDA_microcredential_nextflow_project/images/* $VSC_SCRATCH/.apptainer_cache/
// // Or even, to save space in the cache and avoid copying the images of the exercises (fastqc, multiqc etc) we just copy the ones that concern us 
// // //----> cp /data/gent/courses/2025/vibrepdata_EXT003/shared/apptainer_cache/flash2.sif $VSC_SCRATCH/.apptainer_cache/ 
// // //----> cp /data/gent/courses/2025/vibrepdata_EXT003/shared/apptainer_cache/bwa.sif $VSC_SCRATCH/.apptainer_cache/ 

// Another important thing: the home directory on the HPC does have very little space and therefore the pipeline cannot go beyond 2 samples for the flash... :')
// So now, I cloned the whole repo into my scratch and that's where I'm running it :)


// define parameters
params {
//     samples_path = "${launchDir}/data_raw"
    samples_path = "/data/gent/courses/2025/vibrepdata_EXT003/shared/testdata_lotte_and_matilde"
    // images_path = scratchImages
    // images_path = "/data/gent/courses/2025/vibrepdata_EXT003/shared/apptainer_cache"
    // images_path = "${launchDir}/images"
    // ref_path = "${launchDir}/genome_reference"
    ref_path = "./genome_reference"
    // outdir = "${launchDir}/results"
    // outdir = "./results"
}

// include modules
include { flash2_process } from "./modules/step1_flash2"
include { bwa_process } from "./modules/step2_bwa"

workflow {
    // make the data into an input channel for the FLASH
    samples_ch = channel
        .fromPath("${params.samples_path}/samplesinfo.csv")
        .splitCsv(header: false)
        .map { row ->
            def sample_id = row[0]

            tuple(
                sample_id,
                file("${params.samples_path}/${sample_id}_1.fq.gz"),
                file("${params.samples_path}/${sample_id}_2.fq.gz")
            )
        }
        .view()

    // execute flash2
    flash2_process(samples_ch)

//     def reference_ch = channel
//         .of(
//             file("${params.ref_path}/reference_genes.fasta"),
//             file("${params.ref_path}/borderFile.gff")
//         )

//     // execute bwa on the output of flash2
//     bwa_process(reference_ch, flash2_process.out.merged)

 }