# custom script

 * make minimal 
 * ensure we export 1 plot to results folder
 * containerise (create Dockerfile)
 * upload on image registry -> maybe quay.io to avoid local image
 * copy image on VSC shared folder

 # others - data protection

* ~~Delete all reference files with sensitive content~~
* Create new border file that refers to the positions of ONLY S2 AMPLICONS in the genes_reference
* blast the genes_reference to the total B104 corteva genome and sum the positions to the border file positions
* check if the reference index created from the new pair border-genome is identical to the border-targetgenes