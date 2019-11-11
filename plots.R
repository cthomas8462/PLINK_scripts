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

par<-c("22", "24")

possible_dirs<-sprintf("./%s_par%s", phenotypes, par)

dirs_exist<-possible_dirs[possible_dirs %in% dirs]

pdf(file= test.pdf)

for (i in seq_along(dirs_exist)){
  if(sum(grepl("*full.assoc.logistic", list.files(path= dirs_exist[i])))==1){
    filename<-paste(dirs_exist[i], "/", grep("*full.assoc.logistic", list.files(path= dirs_exist[i]), value = TRUE), sep="")
      #For par 22
      if(grepl("par22", filename)){
      data<-read.table(filename, header=TRUE, stringsAsFactors=FALSE)
      data<--data%>%filter(TEST == "ADDxweekly_oily_fish")
      data<-data %>% select(CHR, SNP, BP, P)
      data[,-2]<-sapply(data[,-2], as.numeric)
      data<-drop_na(data)
      manhattan(data, 
          main = "Title goes here", 
          ylim = c(0, 10), cex = 0.6, 
          annotatePval = 0.00001, annotateTop = FALSE,
          cex.axis = 0.9, col = c("red", "black"), 
          suggestiveline = -log10(1e-05), genomewideline = -log10(5e-08), 
)}
      else if(grepl("par24", filename)){
      data<--data%>%filter(TEST == "ADDxfish_oil_initial")
      data<-data %>% select(CHR, SNP, BP, P)
      data[,-2]<-sapply(data[,-2], as.numeric)
      data<-drop_na(data)
      manhattan(data, 
          main = "Title goes here", 
          ylim = c(0, 10), cex = 0.6, 
          annotatePval = 0.00001, annotateTop = FALSE,
          cex.axis = 0.9, col = c("red", "black"), 
          suggestiveline = -log10(1e-05), genomewideline = -log10(5e-08), 
)}
      
      
      
      
      
      
            }}
dev.off()
        



