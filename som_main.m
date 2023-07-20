clc
fid = fopen("uy734.dat");
file_data = textscan(fid, "%s%s%s");
fclose(fid);

row = length(file_data{1});
lla = file_data{2};
llo = file_data{3};
index = file_data{1};

for ii=1:row
    x(ii) = str2num(cell2mat(llo(ii)));
    y(ii) = str2num(cell2mat(lla(ii)));
end

% plot(x, y, 'r*', 'MarkerSize', 9);

xx = (x-min(x))/(max(x)-min(x));
yy = (y-min(y))/(max(y)-min(y));

% figure
% plot(xx, yy, 'b*', 'MarkerSize', 9);

city_all = [xx; yy]';

% initialization
LR = 0.8;   % learning rate: 0.8
NN_size = length(xx)*8;

NN = rand(NN_size, 2);
n = NN_size;

% training NN
for ii = 1:2700     % 27000

    % choose a random city
    index = fix(rand(1)*734) + 1;
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
            'Position', [1200 scrsz(4)/2 scrsz(4)/2 scrsz(4)/2], ...
            'PaperPositionMode', 'Auto');
        plot(xx, yy, 'r*', 'LineWidth',3, 'MarkerSize', 2);
        hold on; 
        plot(NN(:,1), NN(:,2), 'b-', 'LineWidth', 3);
        set(gca, 'FontSize', 12, 'FontWeight', 'bold')
        hh = title([" iteration = " ii]);
        pause
        close all;
    end


end



    


