#PBS -S /bin/bash
#PBS -q ye_q
#PBS -N multi_GWAS
#PBS -l nodes=2:ppn=64
#PBS -l walltime=7:00:00:00
#PBS -l mem=120gb

#PBS -M michaelfrancis@uga.edu
#PBS -m abe

module load PLINK/1.9b_5-x86_64
cd /work/kylab/share/UKB

phenotypes=("breast_cancer" "prostate_cancer" "LI_colorectal_cancer" \
"colon_sigmoid_cancer" "liver_cancer" "brain_cancer" "cardiac.1" \
"cardiac.2" "cardiac.3" "cardiac.4" "cardiac.5" "cardiac.6" \
"cardiac.7" "cardiac.8" "cardiac.9" "cardiac.10" "cardiac.11" \
"cardiac.12" "cardiac.13" "cardiac.14" "cardiac.15" "cardiac.16" \
"cardiac.17" "cardiac.18" "cardiac.19" "cardiac.20" "cardiac.21")

chr=(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 X Y)

par=(22 23)

#perform GWAS across all chromosomes for 27 phenotypes and two possible GxE interaction terms

for i in ${chr[*]}
        do

        for j in ${phenotypes[@]}
                do
                for k in ${par[*]}
                        do

plink \
--bed ./bedfiles/ukb_cal_chr"$i"_v2.bed \
--bim ./bimfiles/ukb_snp_chr"$i"_v2.bim \
--fam ./famfiles/ukb48818_cal_chr"$i"_v2_s488282.fam \
--pheno ./pheno/pheno_09232019.txt \
--pheno-name $j \
--1 \
--covar ./pheno/covar_09232019.txt \
--covar-name Sex, Age, Townsend, BMI, weekly_oily_fish, fish_oil_initial, \
PCA1, PCA2, PCA3, PCA4, PCA5, PCA6, PCA7, PCA8, PCA9, PCA10 \
--maf 0.05 \
--mind 0.1 \
--logistic \
--hwe 1e-50 midp \
--interaction \
--parameters 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,$k \
--tests 1,18 \
--out GWAS_results_09242019/"$k"_par"$j"_chr"$i"_09242019

done
done
done
