clc
clear all
fid = fopen("uy734.dat");
file_data = textscan(fid, "%s%s%s");
fclose(fid);

Epoch = 2000;
pc = 0.5;
pop_size = 100;

row = length(file_data{1});
lla = file_data{2};
llo = file_data{3};
index = file_data{1};

%%

for iii=1:row % all ii to iii
    x_llo(iii) = str2num(cell2mat(llo(iii)));       % renamed from x to x_llo
    y_lla(iii) = str2num(cell2mat(lla(iii)));       % renamed from y to y_lla
    id_index(iii) = str2num(cell2mat(index(iii)));  % renamed from id to id_index
end

%% added by al

x_50 = x_llo(1, 1:50);
y_50 = y_lla(1, 1:50);
id_50 =id_index(1, 1:50);

%% added by al

xx_50 = (x_50-min(x_50))/(max(x_50)-min(x_50));
yy_50 = (y_50-min(y_50))/(max(y_50)-min(y_50));

%%

city_all = [id_50; xx_50; yy_50]'; % fixed

%%

% ID_perm_all = perms(id_50);

%%

% scrcz = get(0, 'ScreenSize');
% figure('Units', 'pixels',...
%     'Position', [600, scrcz(4)*1/3 scrcz(4)*2/3 scrcz(4)*1/2],...
%     'PaperPositionMode', 'Auto');
% hAx = gca;
% plot(city_all(:,2), city_all(:,3), 'r*', 'LineWidth', 3);
% set(gca, 'FontSize', 12, 'FontWeight', 'bold');
% grid;
% axis image;
% hold on;

%% generate population
   m = 100;
   n = 50;
   [~,p] = sort(rand(m,n),2);
   s = reshape(id_50(p),m,n);
%% population

population = s';

%%
population_M = create_pop(population, city_all);

% M = zeros(50,3,100);
% for k=1:100
%     for i=1:50
%         for j=1:50
%             if city_all(i,1) == population(j,k)
%                 M(j,2:3,k) = city_all(i,2:3);
%                 M(j,1,k) = population(j,k);
%             end
%         end
%     end
% end

% M is tha population with 100 route and position
%% run the EC

for epoch=1:Epoch

    % parent selection
%     fitness = fitness_function_stp(M);
    fitness = fitness_function_stp(population_M);

    [junk, index] = sort(fitness);
    stop_index = 50;   %stop_index = pop_size*pc;

%     parents = M(:, :, index(1:stop_index));
    parents = population_M(:, :, index(1:stop_index));

    %recombination
%     shuffle_seq = randperm(stop_index);
    children_recom = recombination_stp(parents);    % 

    % mutation
    children = mutation_stp(children_recom);    % create 3x child

    % form new genration
    pool = [children population];
%     fitness = fitness_function_stp(population_M);
    pool_M = create_pop(pool, city_all);
    fitness = fitness_function_stp(pool_M);

    [junk index] = sort(fitness);
    population = pool(:, index(1:pop_size));
    population_M = pool_M(:,:, index(1:pop_size));
%     population(:,1);
%     population_M = create_pop(population, city_all);
    x_population = population_M(:,:,1);
%     figure;
%     hAx = gca;
%     plot(hAx, population_M(:, 2),  population_M(:, 3), 'r-');
%     drawnow;

%     plot(hAx, population_M(:, 2, 1),  population_M(:, 3, 1), 'b-');
%     figure
%     scrcz = get(0, 'ScreenSize');
%     figure('Units', 'pixels',...
%         'Position', [600, scrcz(4)*1/3 scrcz(4)*2/3 scrcz(4)*1/2],...
%         'PaperPositionMode', 'Auto');
%     hAx = gca;
%     plot(city_all(:,2), city_all(:,3), 'r*', 'LineWidth', 3);
%     set(gca, 'FontSize', 12, 'FontWeight', 'bold');
%     grid;
%     axis image;
%     hold on;
%     plot(hAx, x_population(:, 2),  x_population(:, 3), 'b-');
%     pause(0.1)
%     for i=1:50
%         
%         plot(hAx, x(i, 2),  x(i, 3), 'b-');
%         drawnow;
%         pause(0.1)
%     end
    if fix(epoch/500) == epoch/500
        scrsz = get(0, 'ScreenSize');
        figure('Unit', 'Pixels', ...
            'Position', [600 scrsz(2)/2 scrsz(4)/2 scrsz(4)/2], ...
            'PaperPositionMode', 'Auto'); 
        plot(city_all(:,1), city_all(:,2), 'r*', 'LineWidth',3, 'MarkerSize', 5);
        hold on; 
        plot(x_population(:,2), x_population(:,3), 'b-', 'LineWidth', 3);
        set(gca, 'FontSize', 12, 'FontWeight', 'bold')
        hh = title([" iteration = " epoch]);
        pause
        close all;
    end


end



