#ml R/3.6.1-foss-2018a-X11-20180131-GACRC
#look at files in /scratch/mf91122/dbGaP1/ARIC/ARIC.1KG.imputed

setwd("/scratch/mf91122/dbGaP1/ARIC/ARIC.1KG.imputed")

list.files()

load("ARIC.AA.chr9.RData")
#ls() #list objects that exist in environment

colnames(geno)[1]<-"#CHROM"
write.table(geno, "ARIC.AA.chr9.vcf")


#01-20-2020 write script that finds snps from table
library(tidyverse)


setwd("/scratch/mf91122/dbGaP1/ARIC/")
snplist<-read.csv("testsnplist.csv")
colnames(snplist)<-c("CHROM", "POS")


files<- grep("ARIC.EA.chr[0-9]+.p[0-9]+.RData", as.character(list.files(path="ARIC.1KG.imputed/")), value=TRUE)
setwd("/scratch/mf91122/dbGaP1/ARIC/ARIC.1KG.imputed/")

x<-list()
for (i in seq_along(files)){
  load(files[i])
  geno1<-as.data.frame(geno)
  match<-geno1[,2] %in% snplist[,2] & geno1[,1] %in% snplist[,1]
  x<-c(x, geno1[match,])}
  
  
  
  
