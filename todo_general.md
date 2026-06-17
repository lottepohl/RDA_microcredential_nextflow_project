# flash2 and bwa

* ~~make the containers work - save the .sif in the place where the images are fetched from~~
* solve the params.outdir thing - why does it keep on saying that we have an 'undefined parameter'?? --> when solved, we can uncomment/substitute the 'publishDir line in the proccesses (both of them)

# samtools and smap

* Lotte can you pull the images with docker and convert them to .sif with your magic??
    ```
    docker pull quay.io/biocontainers/samtools:1.23.1--ha83d96e_0
    docker pull ilvo/smap:latest
    ```

# custom script

* make minimal 
* ensure we export 1 plot to results folder
* containerise (create Dockerfile)
* upload on image registry -> maybe quay.io to avoid local image
* copy image on VSC shared folder
* !!!! Lotte are you sure it's this that we should do? Or should we instead just have the Dockerfile on the Git repo that we're gonna su

# nextflow.config file

* ~~all the preparation we're constantly doing should be possible to be defined in the nextflow.config~~
    ```
    export APPTAINER_CACHEDIR=${VSC_SCRATCH}/.apptainer_cache
    export APPTAINER_TMPDIR=${VSC_SCRATCH}/.apptainer_tmp
    ``` 

# others - project submission etc

* finish readme
* confirm .gitignore
* maybe build a brand new github repository (copy pasting the finished stuff to a new repo basically) to submit? Just because in the beginning we have pushed quite some confidential data from the company and I don't like the idea that although I deleted it now, it's still 'there' in the git tracing...?


# others - data protection

* ~~Delete all reference files with sensitive content~~
* ~~Create new border file that refers to the positions of ONLY S2 AMPLICONS in the genes_reference~~
* ~~blast the genes_reference to the total B104 corteva genome and sum the positions to the border file positions~~
* check if the reference index created from the new pair border-genome is identical to the border-targetgenes