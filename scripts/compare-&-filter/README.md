# Compare and Filter the Direct Inference (Mikado) and BRAKER filtered output
For comparing and filtering the two annotation methods the following files need to be gathered:
1. Direct Inference (Mikado) filtered GFF3 file
2. BRAKER filtered GFF3 file

### Steps overview:

1. Run Mikado Compare with Direct Inference (Mikado) GFF3 as reference and BRAKER GFF3 as predictive
2. Evaluate the Mikado Compare output `mikado_compare.tmap` using the Mikado_Compare_Blank.xlsx file

``` cut -f3 mikado_compare.tmap | sort | uniq -c ```

3. Generate mikado.keep.list, braker.keep.list, both.keep.list, braker.Need2Filter.list from Mikado Compare output (Example: [make_lists.sh](https://github.com/PeanutBase/BIND_annotation/blob/main/scripts/compare-%26-filter/make_lists.sh))
 
