thread{1} = readtable('__best_simulation_csv/dynamic/sorted_DTRACE_dynamic_4/1.csv','ReadVariableNames',true);
thread{2} = readtable('__best_simulation_csv/dynamic/sorted_DTRACE_dynamic_4/2.csv','ReadVariableNames',true);
thread{3} = readtable('__best_simulation_csv/dynamic/sorted_DTRACE_dynamic_4/3.csv','ReadVariableNames',true);
thread{4} = readtable('__best_simulation_csv/dynamic/sorted_DTRACE_dynamic_4/4.csv','ReadVariableNames',true);



hFig = figure(1);
set(hFig, 'Position', [0 0 1280  960]);

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
});

set(objh,'linewidth',4);
%set(legh,'FontSize',14 );

for K = 1:4    
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
            thread_1_end = stamp_start;
            stamp_color = colors(12,:) ;

   end   
   h= plot([stampx_start ; stampx_stop],[K ;K ] , 'LineWidth',40, 'Color', stamp_color );

   hold on;
end
end

xlim([0 thread_end{1}  ]);
ylim([0 5]);

l = ylabel('Thread ID');
set(l,'FontSize',14 );
l = xlabel('Time ($\mu$s)','interpreter','latex');
set(l,'FontSize',14 );
t = title({'Relation between OpenMP Scheduling, \#OpenMP Threads, and Total time for solution in $\mu$s','For 4 OpenMP Thread with DYNAMIC SCHEDULING'},'interpreter','latex');
set(t,'FontSize',18);
set(gca,'YTick',[ 0 1 2 3 4 5]);
set(gca,'YTickLabel',[' '; '1' ; '2' ; '3' ; '4' ; ' ' ]);

xtik=get(gca,'xtick');
s=sprintf('%d',xtik(1));
for i=2:length(xtik)
  s=strvcat(s,sprintf('%d',xtik(i)));
end
set(gca,'xticklabel',s);
