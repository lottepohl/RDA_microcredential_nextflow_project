process copy_images {
    executor 'local'

    output:
    env SCRATCH_IMAGES

    script:
    """
    SCRATCH_IMAGES=\${VSC_SCRATCH}/images
    mkdir -p \${SCRATCH_IMAGES}
    cp -n ${projectDir}/images/*.sif \${SCRATCH_IMAGES}/
    """
}