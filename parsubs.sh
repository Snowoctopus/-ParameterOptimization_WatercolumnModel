#!/bin/bash
set -euxo pipefail
#
#$ -cwd
#$ -j y
#$ -S /bin/bash
#

#for id in {1..2}
#do
id=1
test=test$id
#mkdir -p /home/ncg/MogeDu/GLUE/test$id
#mkdir -p /home/ncg/MogeDu/GLUE/Parameter/test$id
path=/home/ncg/MogeDu/GLUE/$test 
for n in {1..78125}
do echo
 cp -r /home/ncg/MogeDu/GLUE/base/. $path/$n/
 chmod 777 -R /home/ncg/MogeDu/GLUE/.
 
a1=`grep 'gam=' $path/$n/MGbase.f90`
a2=`grep 'gmax=' $path/$n/MGbase.f90`
a3=`grep 'kd=' $path/$n/MGbase.f90`
a4=`grep 'pn_max=' $path/$n/MGbase.f90`
a5=`grep 'pn_max_noo=' $path/$n/MGbase.f90`
a6=`grep 'ynh4_bnh4=' $path/$n/MGbase.f90`
a7=`grep 'yno2_bno2=' $path/$n/MGbase.f90`

#substitute the parameter 
m=$n
index=1
while read var
do
b[$index]="$var"
index=`expr $index + 1`
done < "/home/ncg/MogeDu/GLUE/Parameter/$m.txt"
echo ${b[*]}
sed -i "s|$a1|\gam= ${b[1]}\, \&|g;s|$a2|\gmax= ${b[2]}\, \&|g;s|$a3|\kd= ${b[3]}\, \&|g;s|$a4|\pn_max= ${b[4]}\, \&|g;s|$a5|\pn_max_noo= ${b[5]}D0\, \&|g;s|$a6|\ynh4_bnh4= ${b[6]}D0\, \&|g;s|$a7|\yno2_bno2= ${b[7]}D0\, \&|g" $path/$n/MGbase.f90
done

#nowdir=/home/ncg/MogeDu/GLUE2/$test/
#for i in {1..2}
#do
#cd  $nowdir/$i
#    echo $PWD
#    chmod 777 -R MGbase.f90
#      ifort MGbase.f90 -o MGbase
#       chmod 777 -R /home/ncg/MogeDu/GLUE1/test1/.
#	  ./MGbase
#	  chmod 777 -R /home/ncg/MogeDu/GLUE2/test1/.
	  
#done

echo Congratulations!
date
#cd /home/ncg/MogeDu/GLUE1/
#matlab -nodesktop -nosplash -r "costplot;exit"
