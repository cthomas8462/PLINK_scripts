cd /scratch/mf91122/dbGaP1/ARIC_phenotype

cat phs000280.v3.pht004063.v1.p1.c1.DERIVE13.HMB-IRB.txt |head -20| cut -f20,21


cat phs000280.v3.pht004238.v1.p1.c1.VITA03.HMB-IRB.txt |cut -f26,67 > ../myARIC/ARIC_fish_oil.txt


cat phs000280.v3.pht004063.v1.p1.c1.DERIVE13.HMB-IRB.txt |head -20| cut -f19,20,21,27,33,35,36,37,106,110,120,122

#need fish servings
cat phs000280.v3.pht004068.v1.p1.c1.dtia.HMB-IRB.txt |head -20| cut -f38,122

