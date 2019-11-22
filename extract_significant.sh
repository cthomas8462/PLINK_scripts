#PBS -S /bin/bash
#PBS -q ye_q
#PBS -N extract_significant
#PBS -l nodes=1:ppn=1
#PBS -l walltime=1:00:00:00
#PBS -l mem=8gb

#PBS -M michaelfrancis@uga.edu
#PBS -m abe

now=$(date +"%m_%d_%Y")

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

for i in ${chr[*]}
    do
	  for j in ${phenotypes[@]} 
		  do
			for k in ${par[*]}
          do

cd /scratch/mf91122/UKBimputation/GWAS_results_11142019

if [ -d "$j"_par"$k" ] #if directory exists then go into that directory
	then
	cd "$j"_par"$k"
  awk '{if ($4<5e-05) print $0}' "$j"_par"$k"_fullc.assoc.logistic >> significantSNPs_"$now".txt
  fi

done
done
done
