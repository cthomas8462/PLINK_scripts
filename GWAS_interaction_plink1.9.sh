#PBS -S /bin/bash
#PBS -q batch
#PBS -N GWAS_chr1
#PBS -l nodes=1:ppn=2
#PBS -l walltime=25:00:00:00
#PBS -l mem=15gb

#PBS -M michaelfrancis@uga.edu
#PBS -m ae

module load PLINK/1.9b_5-x86_64
cd /work/kylab/share/UKB/scripts_round6_11142019

now=$(date +"%m_%d_%Y")

phenotypes=("Depress_2wk" "breast_cancer" "prostate_cancer" \ 
"LI_colorectal_cancer" "colon_sigmoid_cancer" "liver_cancer" \ 
"brain_cancer" "squamous_cell" "inflam_bowel" "crohns" \
"rhematoid_arth" "cardiac.1" \
"cardiac.2" "cardiac.3" "cardiac.4" "cardiac.5" "cardiac.6" \
"cardiac.7" "cardiac.8" "cardiac.9" "cardiac.10" "cardiac.11" \
"cardiac.12" "cardiac.13" "cardiac.14" "cardiac.15" "cardiac.16" \
"cardiac.17" "cardiac.18" "cardiac.19" "cardiac.20" "cardiac.21")

chr=(1)

par=(22 24)

#Perform GWAS across single chromosome for 32 binary phenotypes
#Using two possible GxE interaction terms

for i in ${chr[*]}
	do
	for j in ${phenotypes[@]} 
		do
		for k in ${par[*]}
			do

plink \
--bfile /scratch/mf91122/UKBimputation/bgen1.2_to_bed/ukb_chr"$i" \
--pheno /work/kylab/share/UKB/pheno/pheno_11142019.txt \
--pheno-name $j \
--1 \
--covar /work/kylab/share/UKB/pheno/covar_11042019.txt \
--covar-name Sex, Age, Townsend, BMI, weekly_oily_fish, fish_oil_initial, \
PCA1, PCA2, PCA3, PCA4, PCA5, PCA6, PCA7, PCA8, PCA9, PCA10, statins \
--maf 0.05 \
--mind 0.1 \
--logistic interaction \
--hwe 1e-50 midp \
--parameters 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,$k \
--tests 1,18 \
--out /scratch/mf91122/UKBimputation/GWAS_results_11142019/"$j"_par"$k"_chr"$i"_"$now"

done
done
done
