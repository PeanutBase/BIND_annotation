awk '{if ($3 == "=") print $0}' mikado_compare.tmap >> mikado.keep.list
awk '{if ($3 == "_") print $0}' mikado_compare.tmap >> mikado.keep.list
awk '{if ($3 == "c") print $0}' mikado_compare.tmap >> mikado.keep.list
awk '{if ($3 == "C") print $0}' mikado_compare.tmap >> mikado.keep.list
awk '{if ($3 == "e") print $0}' mikado_compare.tmap >> mikado.keep.list
###
awk '{if ($3 == "f,=") print $0}' mikado_compare.tmap >> braker.keep.list
awk '{if ($3 == "f,_") print $0}' mikado_compare.tmap >> braker.keep.list
###
awk '{if ($3 == "f,c") print $0}' mikado_compare.tmap >> mikado.keep.list
###
awk '{if ($3 == "f,C") print $0}' mikado_compare.tmap >> braker.keep.list
awk '{if ($3 == "f,e") print $0}' mikado_compare.tmap >> braker.keep.list
awk '{if ($3 == "f,g") print $0}' mikado_compare.tmap >> braker.keep.list
awk '{if ($3 == "f,G") print $0}' mikado_compare.tmap >> braker.keep.list
awk '{if ($3 == "f,h") print $0}' mikado_compare.tmap >> braker.keep.list
awk '{if ($3 == "f,j") print $0}' mikado_compare.tmap >> braker.keep.list
awk '{if ($3 == "f,J") print $0}' mikado_compare.tmap >> braker.keep.list
awk '{if ($3 == "f,m") print $0}' mikado_compare.tmap >> braker.keep.list
awk '{if ($3 == "f,n") print $0}' mikado_compare.tmap >> braker.keep.list
awk '{if ($3 == "f,o") print $0}' mikado_compare.tmap >> braker.keep.list
###
awk '{if ($3 == "g") print $0}' mikado_compare.tmap >> mikado.keep.list
###
awk '{if ($3 == "G") print $0}' mikado_compare.tmap >> braker.keep.list
###
awk '{if ($3 == "h") print $0}' mikado_compare.tmap >> mikado.keep.list
awk '{if ($3 == "i") print $0}' mikado_compare.tmap >> mikado.keep.list
awk '{if ($3 == "I") print $0}' mikado_compare.tmap >> mikado.keep.list
awk '{if ($3 == "j") print $0}' mikado_compare.tmap >> mikado.keep.list
awk '{if ($3 == "J") print $0}' mikado_compare.tmap >> mikado.keep.list
awk '{if ($3 == "m") print $0}' mikado_compare.tmap >> mikado.keep.list
###
awk '{if ($3 == "n") print $0}' mikado_compare.tmap >> braker.keep.list
###
awk '{if ($3 == "o") print $0}' mikado_compare.tmap >> mikado.keep.list
###
awk '{if ($3 == "p") print $0}' mikado_compare.tmap >> both.keep.list
awk '{if ($3 == "P") print $0}' mikado_compare.tmap >> both.keep.list
###
awk '{if ($3 == "ri") print $0}' mikado_compare.tmap >> mikado.keep.list
awk '{if ($3 == "rI") print $0}' mikado_compare.tmap >> mikado.keep.list
###
awk '{if ($3 == "u") print $0}' mikado_compare.tmap >> braker.Need2Filter.list
###
awk '{if ($3 == "x") print $0}' mikado_compare.tmap >> mikado.keep.list
awk '{if ($3 == "X") print $0}' mikado_compare.tmap >> mikado.keep.list
