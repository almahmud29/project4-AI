function [my_gaussian] = get_neighborhood(winner_index, radix, NN)

if radix < 1
    radix = 1;
end

deltas = abs(winner_index - (0:size(NN,1) - 1));

dis = min(deltas, size(NN, 1) - deltas);

my_gaussian = exp(-dis.^2/2/radix^2);


