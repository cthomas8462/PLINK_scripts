#PBS -S /bin/bash
#PBS -q ye_q
#PBS -N significant-snps
#PBS -l nodes=1:ppn=4
#PBS -l walltime=30:00:00:00
#PBS -l mem=50gb

cd /scratch/mf91122/UKBimputation/8.GWAS_results_12142019
now=$(date +"%m_%d_%Y")


for file in 	/scratch/mf91122/UKBimputation/8.GWAS_results_12142019/* \
		/scratch/mf91122/UKBimputation/8.GWAS_results_12142019/linear/*
do
	awk '{if (($7=="ADDxweekly_oily_fish" || $7=="ADDxfish_oil_initial") && ($12 <=5e-07)) print $0, $(NF+1)=FILENAME}' $file >> \
	significant_"$now".txt
done

awk '!x[$0]++' significant_"$now".txt > significant_"$now"_dupremove.txt
