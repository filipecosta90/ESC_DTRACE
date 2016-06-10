
FigHandle = figure;
set(FigHandle, 'Position', [0, 0, 1280, 460]);

static_1 = min(csvread('__times/static_1_time.csv'));
static_2 = min(csvread('__times/static_2_time.csv'));
static_4 = min(csvread('__times/static_4_time.csv'  ));
static_8 = min(csvread('__times/static_8_time.csv'));
static_16 = min(csvread('__times/static_16_time.csv'));
static_32 = min(csvread('__times/static_32_time.csv'));
static_64 = min(csvread('__times/static_64_time.csv'));

dynamic_1 = min(csvread('__times/dynamic_1_time.csv'));
dynamic_2 = min(csvread('__times/dynamic_2_time.csv'));
dynamic_4 = min(csvread('__times/dynamic_4_time.csv'));
dynamic_8 = min(csvread('__times/dynamic_8_time.csv'));
dynamic_16 = min(csvread('__times/dynamic_16_time.csv'));
dynamic_32 = min(csvread('__times/dynamic_32_time.csv'));
dynamic_64 = min(csvread('__times/dynamic_64_time.csv'));

guided_1 = min(csvread('__times/guided_1_time.csv'));
guided_2 = min(csvread('__times/guided_2_time.csv'));
guided_4 = min(csvread('__times/guided_4_time.csv'));
guided_8 = min(csvread('__times/guided_8_time.csv'));
guided_16 = min(csvread('__times/guided_16_time.csv'));
guided_32 = min(csvread('__times/guided_32_time.csv'));
guided_64 = min(csvread('__times/guided_64_time.csv'));

A = zeros(3,7);

A = [ 
    static_1 static_2 static_4 static_8 static_16 static_32 static_64 ; 
    dynamic_1 dynamic_2 dynamic_4 dynamic_8 dynamic_16 dynamic_32 dynamic_64;
    guided_1 guided_2 guided_4 guided_8 guided_16 guided_32 guided_64 
];


h = tabularHeatMap(A);
t = title({'Relation between OpenMP Scheduling, \#OpenMP Threads, and Total time for solution in $\mu$s'},'interpreter','latex')
set(t,'FontSize',20);

xlabel('# Threads OpenMP');
ylabel('OpenMP Scheduling');
h.XAxisLocation = 'bottom';
h.XTick = [1 2 3 4 5 6 7 ];
h.XTickLabel = {'1', '2', '4', '8', '16', '32', '64'};
h.YTick = [1 2 3];
h.YTickLabel = {'Static', 'Dynamic', 'Guided'};





