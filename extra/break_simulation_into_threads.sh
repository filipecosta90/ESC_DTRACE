#!/bin/bash

cd __best_simulation_csv

rm -r static
rm -r guided
rm -r dynamic
mkdir static
mkdir guided
mkdir dynamic

for schedule in static dynamic guided
do
  cd $schedule
  for file in ../*"_"$schedule"_"*".csv" 
  do
    filename=$(basename "$file")
    extension="${filename##*_}"
    filename="${filename%_*}"
    rm -r $filename
    mkdir $filename
    cd $filename
    filename1=$(basename "$filename")
    nthreads="${filename1##*_}"
    filename1="${filename1%_*}"
    for (( threadid = 1; threadid <= $nthreads ; threadid++ ))
    do
      echo "getting lines of thread num $threadid and saving in $threadid.csv"
      gawk -v thread="$threadid" -F, 'NR == 1 {print $0} $3==thread { print $0 }' ../$file > $threadid".csv"
    done
    cd ..
  done
  cd ..
done

