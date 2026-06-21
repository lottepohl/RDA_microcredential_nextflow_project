// Lotte had this on main.nf:

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




// // stage containers to scratch first
//     copy_images()

//     // use the output path for subsequent processes
//     copy_images.out
//     .map { path -> path.trim() }
//     .set { images_path_ch }

//     // build sample channel
//     samples_ch = channel
//         .fromPath("${params.samples_path}/samplesinfo.csv")
//         .splitCsv(header: false)
//         .map { row ->
//             def sample_id = row[0]
//             tuple(
//                 sample_id,
//                 file("${params.samples_path}/${sample_id}_1.fq.gz"),
//                 file("${params.samples_path}/${sample_id}_2.fq.gz")
//             )
//         }

//     // combine samples with images path
//     images_path_ch
//         .combine(samples_ch)
//         .map { images_path, sample, r1, r2 -> tuple(sample, r1, r2, images_path) }
//         .set { flash2_input_ch }

    // // execute flash2
    // flash2_process(flash2_input_ch)