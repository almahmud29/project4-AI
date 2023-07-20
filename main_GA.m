clear
close all

%%============== define useful parameters

Epoch = 200;
pc = 0.5;   % ratio of parent selection
pm = 0.5;   % ratio used in mutation
sig = 0.01; % standard deviation


%% define circle

x_c = 2.5;  % x coordinate of the center
y_c = 2.5;  % y coordinate of the center
r = 1;      % radius
phi = 0:360;

cir_x = x_c + r*cos(phi*pi/180);
cir_y = y_c + r*sin(phi*pi/180);

cir = [cir_x; cir_y];

scrcz = get(0, 'ScreenSize');
figure('Units', 'pixels',...
    'Position', [600, scrcz(4)*1/3 scrcz(4)*2/3 scrcz(4)*1/2],...
    'PaperPositionMode', 'Auto');
hAx = gca;
plot(cir_x, cir_y, 'r-', 'LineWidth', 3);
set(gca, 'FontSize', 12, 'FontWeight', 'bold');
grid;
axis image;
hold on;
%%%================ 
%% Main Part
%%%================

% Initialize population
pop_size = 52;
population_x = randn(1, pop_size);
population_y = randn(1, pop_size);

population = [population_x; population_y];
plot(population_x, population_y, 'b*');

% run the EC

for epoch = 1:Epoch
    % parent selection
    fitness = fitness_function(cir, population);
    [junk, index] = sort(fitness);
    stop_index = pop_size*pc;

    parents = population(:, index(1:stop_index));

    %recombination
    shuffle_seq = randperm(stop_index);
    children_recom = recombination(parents);

    % mutation
    children = mutation(children_recom, sig, pm);

    % form new generation
    pool = [children population];
    fitness = fitness_function(cir, pool);
    [junk index] = sort(fitness);
    population = pool(:, index(1:pop_size));
    population(:,1)

    plot(hAx, population(1, 1),  population(2, 1), 'r.');
    drawnow;
end




