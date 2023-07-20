function children = mutation(children_recom, sig, pm)

l_cr = length(children_recom);
shuffle_seq = randperm(l_cr);
stop_index = fix(l_cr*pm);

children = children_recom;

for ii = 1:stop_index
    children(:, shuffle_seq(ii)) = children(:, shuffle_seq(ii)) + sig*randn(1,2)';
end

