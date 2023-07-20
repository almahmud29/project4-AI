
clc
fid = fopen("uy734.dat");
file_data = textscan(fid, "%s%s%s");
fclose(fid);

row = length(file_data{1});
lla = file_data{2};
llo = file_data{3};
index = file_data{1};

%%

for ii=1:row
    x(ii) = str2num(cell2mat(llo(ii)));
    y(ii) = str2num(cell2mat(lla(ii)));
end

%% added by al

x_50 = x(1, 1:50);
y_50 = y(1, 1:50);

%% added by al

xx_50 = (x_50-min(x_50))/(max(x_50)-min(x_50));
yy_50 = (y_50-min(y_50))/(max(y_50)-min(y_50));

%%

city_all = [xx_50; yy_50]';

%%

% initialization
LR = 0.8;   % learning rate: 0.8
NN_size = length(xx_50)*8;
NN = rand(NN_size, 2);
n = NN_size;

%%

% training NN
for ii = 1:5000

    % choose a random city
    index = fix(rand(1)*50) + 1;
    city = city_all(index, :);

    % SOM
    winner_index = select_winner(NN, city);
    [my_gaussian] = get_neighborhood(winner_index, fix(n/8), NN);

    % Update neurons
    NN = NN + my_gaussian'*LR.*(city-NN);
    LR = LR*0.99997;
    n = n*0.997;

    if fix(ii/500) == ii/500
        scrsz = get(0, 'ScreenSize');
        figure('Unit', 'Pixels', ...
            'Position', [600 scrsz(2)/2 scrsz(4)/2 scrsz(4)/2], ...
            'PaperPositionMode', 'Auto'); 
        plot(xx_50, yy_50, 'r*', 'LineWidth',3, 'MarkerSize', 5);
        hold on; 
        plot(NN(:,1), NN(:,2), 'b-', 'LineWidth', 3);
        set(gca, 'FontSize', 12, 'FontWeight', 'bold')
        hh = title([" iteration = " ii]);
        pause
        close all;
    end

end
    


