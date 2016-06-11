thread_1_csv = readtable('__best_simulation_csv/static/sorted_DTRACE_static_1/1.csv','ReadVariableNames',true);
thread_1_start;
thread_1_end;

for n = 1:length(thread_1_csv.TYPE)
   cell =  thread_1_csv.TYPE( n, 1);
   start = strfind(cell,'CREATE');
   if ( isempty(start{1}) == 0 )
       thread_1_start = thread_1_csv.TIMESTAMP_us_( n, 1);
   end
   
end