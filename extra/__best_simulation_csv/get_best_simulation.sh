#!/bin/bash

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
    filename1=$(basename "$filename")
    nthreads="${filename1##*_}"
    filename1="${filename1%_*}"
    echo $nthreads
    for (( thread = 1; $thread <= $nthreads ; thread++ ))
    do
      gawk -F, '$2==$nthreads { print $2 }' $file 
      echo "thread $thread"
    done
  done
  cd ..
done

