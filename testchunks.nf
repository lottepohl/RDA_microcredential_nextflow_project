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