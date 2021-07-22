# Compare and Filter the Direct Inference (Mikado) and BRAKER filtered output
For comparing and filtering the two annotation methods the following files need to be gathered:
1. Direct Inference (Mikado) filtered GFF3 file
2. BRAKER filtered GFF3 file

### Steps overview:

1. Run Mikado Compare with Direct Inference (Mikado) GFF3 as reference and BRAKER GFF3 as predictive
2. Evaluate the Mikado Compare output `mikado_compare.tmap` using the Mikado_Compare_Blank.xlsx file
3. Generate mikado.keep.list, braker.keep.list, both.keep.list from Mikado Compare output
4. 
