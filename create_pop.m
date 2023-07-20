function population_M = create_pop(population, city_all)

x_pop = length(population);
M = zeros(50,3,x_pop);
for k=1:x_pop   % from 100 to x_pop
    for i=1:50
        for j=1:50
            if city_all(i,1) == population(j,k)
                M(j,2:3,k) = city_all(i,2:3);
                M(j,1,k) = population(j,k);
            end
        end
    end
end

population_M = M;