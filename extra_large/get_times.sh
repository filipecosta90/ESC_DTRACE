#!/bin/bash

rm -r __times
mkdir __times

cd __csv
rm *"_time.csv"
for schedule in static dynamic guided
do
  for nthreads in 1 2 4 8 16 32 64
  do
    cat *"_"$schedule"_"$nthreads"_"*".csv" | grep "Time: " | sed 's/Time://g' | sed 's/usecs//g' |  sort > $schedule"_"$nthreads"_time.csv"
  done
done


mv *"_time.csv" ../__times
