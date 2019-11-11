#PBS -S /bin/bash
#PBS -q ye_q
#PBS -N plots
#PBS -l nodes=1:ppn=1
#PBS -l walltime=1:00:00:00
#PBS -l mem=8gb

#PBS -M michaelfrancis@uga.edu
#PBS -m abe

#Load R
ml R/3.6.1-foss-2018a-X11-20180131-GACRC

library(qqman)
library(plyr)
library(tidyverse)

setwd("/scratch/mf91122/UKBimputation/GWAS_results_11072019")

dirs<-list.dirs(path = ".")

phenotypes<-c("Depress_2wk", "breast_cancer", "prostate_cancer",
"LI_colorectal_cancer", "colon_sigmoid_cancer", "liver_cancer",
"brain_cancer", "squamous_cell", "inflam_bowel", "crohns",
"rhematoid_arth", "cardiac.1",
"cardiac.2", "cardiac.3", "cardiac.4", "cardiac.5", "cardiac.6", 
"cardiac.7", "cardiac.8", "cardiac.9", "cardiac.10", "cardiac.11", 
"cardiac.12", "cardiac.13", "cardiac.14", "cardiac.15", "cardiac.16",
"cardiac.17", "cardiac.18", "cardiac.19", "cardiac.20", "cardiac.21")



data<-read.table("ukb_chr20_vif100.assoc.logistic", 
                  header = TRUE, stringsAsFactors = FALSE)
