#!/usr/bin/env Rscript
library(devtools)
library(phylostratr)
library(reshape2)
library(taxizedb)
library(dplyr)
library(readr)
library(magrittr)
library(knitr)
library(ggtree)
library(phytools)
weights=uniprot_weight_by_ref()
focal_taxid <- '3818'
strata <-
uniprot_strata(focal_taxid, from=2) %>%
strata_apply(f=diverse_subtree, n=10, weights=weights) %>%
use_recommended_prokaryotes %>%
add_taxa(c('4932', '9606')) %>%
uniprot_fill_strata
#strata@tree <- bind.tip(strata@tree, "38733", where=18)
#strata <- prune(strata, '121088', type='name')
#strata <- prune(strata, '38733', type='name')
#strata <- prune(strata, '531291', type='name')
#strata <- prune(strata, '511051', type='name')
strata %>% strata_convert(target='all', to='name') %>% sort_strata %>% plot
strata <- strata_blast(strata, blast_args=list(nthreads=8)) %>% strata_besthits
results <- merge_besthits(strata)
phylostrata <- stratify(results, classify_by_adjusted_pvalue(0.001))
plot_heatmaps(results, "heatmaps.pdf", tree=strata@tree, focal_id=focal_taxid)
write.csv(phylostrata, "phylostrata_table.csv")
tabled <- table(stratify(results)$mrca_name)
write.csv(tabled, "phylostrata_stats.csv")
prot <- proteome_stats_table(strata)
strata2 <- strata_convert(strata, target='all', to='name')
g1 <- plot_proteome_stats(strata2)
g2 <- plot_proteome_lengths(strata2)
pdf("phylostrata_plots.pdf", width=11, height=8.5)
plot(g1)
plot(g2)
dev.off()
