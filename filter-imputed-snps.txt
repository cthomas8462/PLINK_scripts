#PBS -S /bin/bash
#PBS -q highmem_q
#PBS -N filter-pgen
#PBS -l nodes=2:ppn=16
#PBS -l walltime=30:00:00:00
#PBS -l mem=300gb

module load PLINK/2.00-alpha2-x86_64-20191128
cd /work/kylab/mike/UKB/quality-scores

chr=(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 X XY)

#A list of SNPs for each chromosome which have quality score >= 0.5 can be generated using this script:

chr=(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 X XY)

for i in ${chr[*]}
do
  awk '{if ($8 >=0.5) print $2}' ukb_mfi_chr"$i"_v3.txt > ukb_mfi_keepsnps_chr"$i".txt
done

#PLINK2 can be used to generate pgen files that have only the SNPs that were found to have score >=0.5 with this script:

for i in ${chr[*]}
	do

plink2 \
--pfile /scratch/mf91122/UKBimputation/plink2_pfile_imputation/ukb_imp_chr"$i" \
--make-pgen \
--extract /work/kylab/mike/UKB/quality-scores/mfi/ukb_mfi_keepsnps_chr"$i".txt \
--out /scratch/mf91122/UKBimputation/filtered_plink2_pfile_imputation/plink-filtered-chr"$i"

done
