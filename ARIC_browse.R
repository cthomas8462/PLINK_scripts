#ml R/3.6.1-foss-2018a-X11-20180131-GACRC
#look at files in /scratch/mf91122/dbGaP1/ARIC/ARIC.1KG.imputed

setwd("/scratch/mf91122/dbGaP1/ARIC/ARIC.1KG.imputed")

list.files()

load("ARIC.AA.chr9.RData")
#ls() #list objects that exist in environment

colnames(geno)[1]<-"#CHROM"
write.table(geno, "ARIC.AA.chr9.vcf")
