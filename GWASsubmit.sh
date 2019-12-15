#PBS -S /bin/bash
#PBS -q batch
#PBS -N GWAS_submit
#PBS -l nodes=1:ppn=1
#PBS -l walltime=30:00:00:00
#PBS -l mem=5gb


cd /work/kylab/share/UKB/scripts_round8_12132019

phenotypes=("Depress_2wk" "breast_cancer" "prostate_cancer" \ 
"LI_colorectal_cancer" "colon_sigmoid_cancer" "liver_cancer" \ 
"brain_cancer" "squamous_cell" "inflam_bowel" "crohns" \
"rhematoid_arth" "cardiac.1" \
"cardiac.2" "cardiac.3" "cardiac.4" "cardiac.5" "cardiac.6" \
"cardiac.7" "cardiac.8" "cardiac.9" "cardiac.10" "cardiac.11" \
"cardiac.12" "cardiac.13" "cardiac.14" "cardiac.15" "cardiac.16" \
"cardiac.17" "cardiac.18" "cardiac.19" "cardiac.20" "cardiac.21")

par=(22 24)


for j in ${phenotypes[@]} 
	do
	for k in ${par[*]}
		do


qsub /work/kylab/share/UKB/scripts_round8_12132019/manyscripts/"$j"_par"$k".sh

done
done
