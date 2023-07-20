function [winnder_index] = select_winner(NN, city)

dis = sqrt( (NN(:, 1) - city(1,1)).^2 + (NN(:, 2) - city(1,2)).^2);

[winner_distance, winnder_index] = min(dis);

