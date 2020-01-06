#PBS -S /bin/bash
#PBS -q ye_q
#PBS -N sortC
#PBS -l nodes=1:ppn=1
#PBS -l walltime=1:00:00:00
#PBS -l mem=8gb

cd /scratch/mf91122/UKBimputation/11.GWAS-results_01-04-2020_FO_24_std

phenotypes=("Depress_2wk" "breast_cancer" "prostate_cancer" \ 
"LI_colorectal_cancer" "colon_sigmoid_cancer" "liver_cancer" \ 
"brain_cancer" "squamous_cell" "inflam_bowel" "crohns" \
"rhematoid_arth" "T2D" "cardiac.1" \
"cardiac.2" "cardiac.3" "cardiac.4" "cardiac.5" "cardiac.6" \
"cardiac.7" "cardiac.8" "cardiac.9" "cardiac.10" "cardiac.11" \
"cardiac.12" "cardiac.13" "cardiac.14" "cardiac.15" "cardiac.16" \
"cardiac.17" "cardiac.18" "cardiac.19" "cardiac.20" "cardiac.21" \
"LDL" "TAGs" "Tot_Chol")

chr=(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 X XY)

par=(35)

###SORT===============================================================

echo Sorting data...
for i in ${chr[*]}
        do
	for j in ${phenotypes[@]} 
		do
			for k in ${par[*]}
				do

mkdir "$j"_par"$k" 2>/dev/null
mv chr"$i"_par"$k"_*."$j".glm* "$j"_par"$k" 2>/dev/null

mkdir log_and_nosex 2>/dev/null
mv *.log log_and_nosex 2>/dev/null
mv *nosex* log_and_nosex 2>/dev/null
mv *irem* log_and_nosex 2>/dev/null
mv *.hh* log_and_nosex 2>/dev/null
mv *mindrem.id* log_and_nosex 2>/dev/null

done
done
done

cd /scratch/mf91122/UKBimputation/11.GWAS-results_01-04-2020_FO_24_std
rmdir * 2>/dev/null

###COMBINE====================================================

echo Removing files of size zero--initial pass...
cd /scratch/mf91122/UKBimputation/11.GWAS-results_01-04-2020_FO_24_std
find ./ -size  0 -print0 |xargs -0 rm --


#check if files exist

for j in ${phenotypes[@]} 
	do
		for k in ${par[*]}
			do

cd /scratch/mf91122/UKBimputation/11.GWAS-results_01-04-2020_FO_24_std
#if directory exists then go into that directory
if [ -d "$j"_par"$k" ]
	then
	cd "$j"_par"$k"

	filecount=$(ls | wc -l)
	echo filecount for "$j"_par"$k" is "$filecount"

	if [ "$filecount" == 24 ]
	then
		echo Combining "${filecount}" files in "$j"_par"$k"
		cat * > "$j"_par"$k"_full
	fi

	if [ "$filecount" == 25 -a "$k" == 35 ]
	then
			echo Processing "${filecount}" files in "$j"_par"$k"...
			awk -F " " '{if ($7=="ADDxFish_Oil_Supp")print $0}' "$j"_par"$k"_full > \
				"$j"_par"$k".fullb
        		awk '{print $1,$3,$2,$12}' "$j"_par"$k".fullb > \
		        	"$j"_par"$k".fullc
		echo "$j"_par"$k" completed.
	else 
		echo There are "${filecount}" files in "$j"_par"$k"
	fi

fi
done; done

echo Removing files of size zero--final pass...
cd /scratch/mf91122/UKBimputation/11.GWAS-results_01-04-2020_FO_24_std
find ./ -size  0 -print0 |xargs -0 rm --
