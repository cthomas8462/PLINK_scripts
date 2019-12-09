#MAKE MANHATTAN PLOTS FOR COMPLETED GWAS PHENOTYPES
#Load R
#ml R/3.6.1-foss-2018a-X11-20180131-GACRC

library(qqman)
library(plyr)
library(tidyverse)

setwd("/scratch/mf91122/UKBimputation/GWAS_results_11222019")

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

eg<-expand.grid(phenotypes, par)
possible_dirs<-sprintf("./%s_par%s", eg[,1], eg[,2])

dirs_exist<-possible_dirs[possible_dirs %in% dirs]


numfiles<- 0

#count number of pages necessary
for (i in seq_along(dirs_exist)){
	if(sum(grepl("*fullc.assoc.logistic", list.files(path= dirs_exist[i])))==1){
		numfiles<-numfiles+1}}

numpages<-ceiling(numfiles/6)

##FIX HERE

for (i in seq_along(dirs_exist)){
	if(sum(grepl("*fullc.assoc.logistic", list.files(path= dirs_exist[i])))==1){
		filename<-paste(dirs_exist[i], "/", grep("*fullc.assoc.logistic", list.files(path= dirs_exist[i]), value = TRUE), sep="")
		
		for (j in seq_along(numpages))){
			pngfilename=paste("./plotoutput/manhattan", numpages, Sys.Date(), sep="_")
			png(file=pngfilename)
			par(mfrow=c(3,2))
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
			dev.off()
			}
  
          }}

