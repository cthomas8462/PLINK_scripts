#PBS -S /bin/bash
#PBS -q ye_q
#PBS -N plots
#PBS -l nodes=1:ppn=4
#PBS -l walltime=1:00:00:00
#PBS -l mem=20gb

#PBS -M michaelfrancis@uga.edu
#PBS -m abe

#Load R
#ml R/3.6.1-foss-2018a-X11-20180131-GACRC

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

par<-c("22", "24")

possible_dirs<-sprintf("./%s_par%s", phenotypes, par)

dirs_exist<-possible_dirs[possible_dirs %in% dirs]

png(file= "test5.png")
par(mfrow=c(2,2))

for (i in seq_along(dirs_exist)){
  if(sum(grepl("*fullc.assoc.logistic", list.files(path= dirs_exist[i])))==1){
     filename<-paste(dirs_exist[i], "/", grep("*fullc.assoc.logistic", list.files(path= dirs_exist[i]), value = TRUE), sep="")
	data<-read.table(filename, header=FALSE, stringsAsFactors=FALSE)
	colnames(data)= c("CHR", "SNP", "BP", "P")
	data[,-2]<-sapply(data[,-2], as.numeric)
	data<-drop_na(data)
	manhattan(data, 
		main = paste(filename), 
		ylim = c(0, 10), cex = 0.6, 
		annotatePval = 0.00001, annotateTop = FALSE,
		cex.axis = 0.9, col = c("red", "black"), 
		suggestiveline = -log10(1e-05), genomewideline = -log10(5e-08),
		chrlabs = c(1:22, "X", "XY") 
)
  
          }}
dev.off()