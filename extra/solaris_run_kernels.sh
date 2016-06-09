#!bin/bash

for schedule in static dynamic guided
do
  export OMP_SCHEDULE="$schedule"
  for nthreads in 1 2 4 8 16 32 64
    do
      echo "schedulling setted to $OMP_SCHEDULE"
      echo   "./exe2_v2 $nthreads"
      ./dtrace -s threaded.d -c "./exe2_v2 $nthreads"
#>> "DTRACE_"$method"_"$nthreads"_"0"_"$size"_"$nthreads".csv"
  done
done

mkdir __csv
mv DTRACE*.csv __csv
