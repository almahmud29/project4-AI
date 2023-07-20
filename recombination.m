function children = recombination(parents)

l_child = length(parents);
children = zeros(2, l_child);

for ii=1:2:l_child
    children(:,ii) = [parents(1,ii) parents(2,ii+1)];
    children(:,ii+1) = [parents(1,ii+1) parents(2,ii)];
end





