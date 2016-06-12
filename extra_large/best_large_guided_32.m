thread{1} = readtable('__best_simulation_csv/guided/sorted_DTRACE_262144_guided_32/1.csv','ReadVariableNames',true);
thread{2} = readtable('__best_simulation_csv/guided/sorted_DTRACE_262144_guided_32/2.csv','ReadVariableNames',true);
thread{3} = readtable('__best_simulation_csv/guided/sorted_DTRACE_262144_guided_32/3.csv','ReadVariableNames',true);
thread{4} = readtable('__best_simulation_csv/guided/sorted_DTRACE_262144_guided_32/4.csv','ReadVariableNames',true);
thread{5} = readtable('__best_simulation_csv/guided/sorted_DTRACE_262144_guided_32/5.csv','ReadVariableNames',true);
thread{6} = readtable('__best_simulation_csv/guided/sorted_DTRACE_262144_guided_32/6.csv','ReadVariableNames',true);
thread{7} = readtable('__best_simulation_csv/guided/sorted_DTRACE_262144_guided_32/7.csv','ReadVariableNames',true);
thread{8} = readtable('__best_simulation_csv/guided/sorted_DTRACE_262144_guided_32/8.csv','ReadVariableNames',true);
thread{9} = readtable('__best_simulation_csv/guided/sorted_DTRACE_262144_guided_32/9.csv','ReadVariableNames',true);
thread{10} = readtable('__best_simulation_csv/guided/sorted_DTRACE_262144_guided_32/10.csv','ReadVariableNames',true);
thread{11} = readtable('__best_simulation_csv/guided/sorted_DTRACE_262144_guided_32/11.csv','ReadVariableNames',true);
thread{12} = readtable('__best_simulation_csv/guided/sorted_DTRACE_262144_guided_32/12.csv','ReadVariableNames',true);
thread{13} = readtable('__best_simulation_csv/guided/sorted_DTRACE_262144_guided_32/13.csv','ReadVariableNames',true);
thread{14} = readtable('__best_simulation_csv/guided/sorted_DTRACE_262144_guided_32/14.csv','ReadVariableNames',true);
thread{15} = readtable('__best_simulation_csv/guided/sorted_DTRACE_262144_guided_32/15.csv','ReadVariableNames',true);
thread{16} = readtable('__best_simulation_csv/guided/sorted_DTRACE_262144_guided_32/16.csv','ReadVariableNames',true);
thread{17} = readtable('__best_simulation_csv/guided/sorted_DTRACE_262144_guided_32/17.csv','ReadVariableNames',true);
thread{18} = readtable('__best_simulation_csv/guided/sorted_DTRACE_262144_guided_32/18.csv','ReadVariableNames',true);
thread{19} = readtable('__best_simulation_csv/guided/sorted_DTRACE_262144_guided_32/19.csv','ReadVariableNames',true);
thread{20} = readtable('__best_simulation_csv/guided/sorted_DTRACE_262144_guided_32/20.csv','ReadVariableNames',true);
thread{21} = readtable('__best_simulation_csv/guided/sorted_DTRACE_262144_guided_32/21.csv','ReadVariableNames',true);
thread{22} = readtable('__best_simulation_csv/guided/sorted_DTRACE_262144_guided_32/22.csv','ReadVariableNames',true);
thread{23} = readtable('__best_simulation_csv/guided/sorted_DTRACE_262144_guided_32/23.csv','ReadVariableNames',true);
thread{24} = readtable('__best_simulation_csv/guided/sorted_DTRACE_262144_guided_32/24.csv','ReadVariableNames',true);
thread{25} = readtable('__best_simulation_csv/guided/sorted_DTRACE_262144_guided_32/25.csv','ReadVariableNames',true);
thread{26} = readtable('__best_simulation_csv/guided/sorted_DTRACE_262144_guided_32/26.csv','ReadVariableNames',true);
thread{27} = readtable('__best_simulation_csv/guided/sorted_DTRACE_262144_guided_32/27.csv','ReadVariableNames',true);
thread{28} = readtable('__best_simulation_csv/guided/sorted_DTRACE_262144_guided_32/28.csv','ReadVariableNames',true);
thread{29} = readtable('__best_simulation_csv/guided/sorted_DTRACE_262144_guided_32/29.csv','ReadVariableNames',true);
thread{30} = readtable('__best_simulation_csv/guided/sorted_DTRACE_262144_guided_32/30.csv','ReadVariableNames',true);
thread{31} = readtable('__best_simulation_csv/guided/sorted_DTRACE_262144_guided_32/31.csv','ReadVariableNames',true);
thread{32} = readtable('__best_simulation_csv/guided/sorted_DTRACE_262144_guided_32/32.csv','ReadVariableNames',true);


hFig = figure(1);
set(hFig, 'Position', [0 0 1280  1120]);

bg = [1 1 1; 0 0 0];
colors = distinguishable_colors(12,bg);

hold on;
h0= plot([-1 ; -1],[1 ;1 ] , 'LineWidth',1, 'Color', 'cyan' ); %begin
h1= plot([-1 ; -1],[1 ;1 ] , 'LineWidth',1, 'Color', 'green' ); %create
h2= plot([-1 ; -1],[1 ;1 ] , 'LineWidth',1, 'Color', 'blue' ); %restart
h3= plot([-1 ; -1],[1 ;1 ] , 'LineWidth',1, 'Color', colors(8,:) ); %sleep


%  h3= plot([-1 ; -1],[1 ;1 ] , 'LineWidth',1, 'Color', colors(1,:) ); %kernel_mutex
%  h4= plot([-1 ; -1],[1 ;1 ] , 'LineWidth',1, 'Color', colors(2,:) );%kernel_RW_lock
%  h5= plot([-1 ; -1],[1 ;1 ] , 'LineWidth',1, 'Color', colors(3,:) ); %cond_var
%  h6= plot([-1 ; -1],[1 ;1 ] , 'LineWidth',1, 'Color', colors(4,:) ); %kernel_semaphore
%  h7= plot([-1 ; -1],[1 ;1 ] , 'LineWidth',1, 'Color', colors(5,:)); %user_level_lock
%  h8= plot([-1 ; -1],[1 ;1 ] , 'LineWidth',1, 'Color', colors(6,:) ); %user_level_PI_lock
%  h9= plot([-1 ; -1],[1 ;1 ] , 'LineWidth',1, 'Color', colors(7,:) ); %shuttle

h10= plot([-1 ; -1],[1 ;1 ] , 'LineWidth',1, 'Color', 'magenta' ); %migration
h11= plot([-1 ; -1],[1 ;1 ] , 'LineWidth',1, 'Color', 'red' ); %preempted
h12= plot([-1 ; -1],[1 ;1 ] , 'LineWidth',1, 'Color', 'black' ); %exit
h13= plot([-1 ; -1],[1 ;1 ] , 'LineWidth',1, 'Color',  colors(12,:)  ); %exit

[legh,objh,outh,outm]  = legend( [h0 h1 h2 h3 h10 h11 h12 h13 ], {
'KERNEL BEGIN',
'THREAD CREATED',
'THREAD RESTARTED ON SAME CPU',
'THREAD SLEEP',
%'SLEEP ON KERNEL MUTEX',
%'SLEEP ON KERNEL RW LOCK',
%'SLEEP ON KERNEL COND VAR',
%'SLEEP ON KERNEL SEMAPHORE',
%'SLEEP ON USER LEVEL LOCK',
%'SLEEP ON USER LEVEL PI LOCK',
%'SLEEP ON SHUTTLE',
'THREAD MIGRATION FROM CPU', 
'THREAD PREEMPTED',
'THREAD EXIT',
'KERNEL END'
}, 'Location' , 'southoutside' );

set(objh,'linewidth',4);

for K = 1:32
  for n = 1:length(thread{K}.TYPE)-1
    clear begin;
      clear kernel_end;
      clear  create;
      clear exit;
      clear create;
      clear restart;
      clear preempted;
      clear sleep;
      clear exit;
      clear migration;
      clear stolen;
      clear stamp_color;

      cell =  thread{K}.TYPE( n, 1);
      begin = strfind(cell,'BEGIN');
      kernel_end = strfind(cell,'END');
      create = strfind(cell,'CREATE');
      exit = strfind(cell,'EXIT');
      create = strfind(cell,'CREATE');
      restart = strfind(cell,'RESTART');
      preempted = strfind(cell,'PREEMPTED');
      sleep = strfind(cell,'SLEEPING');
      exit = strfind(cell,'EXIT');
      migration = strfind(cell,'CPU MIGRATION');
      stolen = strfind(cell,'STOLEN');
      stamp_start = thread{K}.TIMESTAMP_us_( n, 1);
      stamp_stop = thread{K}.TIMESTAMP_us_( n+1, 1);
      stampx_start = transpose (stamp_start);
      stampx_stop = transpose (stamp_stop);

      if ( isempty(begin{1}) == 0 )
        thread_start{K} = stamp_start;
        stamp_color = 'cyan';

 elseif ( isempty(create{1}) == 0 )
       stamp_color = 'green';

   elseif ( isempty(exit{1}) == 0  )
       thread_end{K} = stamp_start;
       stamp_color = 'black';

     elseif ( isempty(restart{1}) == 0  )
        stamp_color = 'blue';

      elseif ( isempty(preempted{1}) == 0  )
        stamp_color = 'red';

      elseif ( isempty(sleep{1}) == 0  )
              stamp_color = colors(8,:);

      elseif ( isempty(migration{1}) == 0  )
            stamp_color = 'magenta';

          elseif ( isempty(kernel_end{1}) == 0  )
            thread_end{K} = stamp_start;
            stamp_color = colors(12,:) ;

     end   
   h= plot([stampx_start ; stampx_stop],[K ;K ] , 'LineWidth',20, 'Color', stamp_color );

   hold on;
end
end

xlim([0 1.8257e+05 ]);
ylim([0 33]);


l = ylabel('Thread ID');
set(l,'FontSize',14 );
l = xlabel('Time ($\mu$s)','interpreter','latex');
set(l,'FontSize',14 );
t = title({'Relation between OpenMP Scheduling, \#OpenMP Threads, and Total time for solution in $\mu$s','For 32 OpenMP Threads with GUIDED SCHEDULING'},'interpreter','latex')
set(t,'FontSize',18);
A = [ 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33  ];
B = ['  '; ' 1' ; ' 2' ; ' 3' ; ' 4' ; ' 5'; ' 6' ; ' 7' ; ' 8' ; ' 9'; '10' ; '11' ; '12'; '13' ; '14' ; '15' ; '16' ; '17' ; '18' ; '19' ; '20' ; '21' ; '22' ; '23' ; '24' ; '25' ; '26' ; '27' ; '28' ; '29' ; '30' ; '31' ; '32' ; '  ' ];

set(gca,'YTick', A);
set(gca,'YTickLabel', B);

 xtik=get(gca,'xtick');
 s=sprintf('%d',xtik(1));
 for i=2:length(xtik)
 s=strvcat(s,sprintf('%d',xtik(i)));
 end
 set(gca,'xticklabel',s)



