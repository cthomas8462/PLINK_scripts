#PBS -S /bin/bash
#PBS -q batch
#PBS -N GWAS_replicate
#PBS -l nodes=1:ppn=1
#PBS -l walltime=30:00:00:00
#PBS -l mem=5gb

#PBS -M michaelfrancis@uga.edu
#PBS -m ae

cd /work/kylab/share/UKB/scripts_round7_11202019

phenotypes=("Depress_2wk" "breast_cancer" "prostate_cancer" \ 
"LI_colorectal_cancer" "colon_sigmoid_cancer" "liver_cancer" \ 
"brain_cancer" "squamous_cell" "inflam_bowel" "crohns" \
"rhematoid_arth" "cardiac.1" \
"cardiac.2" "cardiac.3" "cardiac.4" "cardiac.5" "cardiac.6" \
"cardiac.7" "cardiac.8" "cardiac.9" "cardiac.10" "cardiac.11" \
"cardiac.12" "cardiac.13" "cardiac.14" "cardiac.15" "cardiac.16" \
"cardiac.17" "cardiac.18" "cardiac.19" "cardiac.20" "cardiac.21")

chr=(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 X XY)
par=(22 24)

now=$(date +"%m_%d_%Y")

IFS=$'\n'

#Create many many scripts using echo and for loops

for i in ${chr[*]}
	do
	for j in ${phenotypes[@]} 
		do
		for k in ${par[*]}
			do


echo "#PBS -S /bin/bash
#PBS -q batch
#PBS -N GWAS_"$j"_par"$k"_chr"$i"
#PBS -l nodes=1:ppn=1
#PBS -l walltime=30:00:00:00
#PBS -l mem=2gb

#PBS -M michaelfrancis@uga.edu
#PBS -m ae

module load PLINK/1.9b_5-x86_64
cd /work/kylab/share/UKB/scripts_round7_11202019


plink \
--bfile /scratch/mf91122/UKBimputation/bgen1.2_to_bed/ukb_chr"$i" \
--pheno /work/kylab/share/UKB/pheno/pheno_11142019.txt \
--pheno-name $j \
--1 \
--covar /work/kylab/share/UKB/pheno/covar_11042019.txt \
--covar-name Sex, Age, Townsend, BMI, weekly_oily_fish, fish_oil_initial, \
PCA1, PCA2, PCA3, PCA4, PCA5, PCA6, PCA7, PCA8, PCA9, PCA10, statins \
--maf 0.01 \
--mind 0.05 \
--geno 0.02 \
--logistic interaction \
--hwe 1e-6 midp \
--parameters 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,$k \
--tests 1,18 \
--allow-extra-chr \
--out /scratch/mf91122/UKBimputation/GWAS_results_11202019/"$j"_par"$k"_chr"$i"_"$now"
" > /work/kylab/share/UKB/scripts_round7_11202019/manyscripts/"$j"_par"$k"_chr"$i".sh

done
done
done
