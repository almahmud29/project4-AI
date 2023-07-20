function fitness = fitness_function(cir, population)

[x_max, x_max_index] = max(cir(1,:));
[x_min, x_min_index] = min(cir(1,:));
[y_max, y_max_index] = max(cir(2,:));
[y_min, y_min_index] = min(cir(2,:));

dis_l = sqrt( (population(1,:) - cir(1, x_max_index)).^2 + (population(2,:) - cir(2, x_max_index)).^2);
dis_r = sqrt( (population(1,:) - cir(1, x_min_index)).^2 + (population(2,:) - cir(2, x_min_index)).^2);

dis_t = sqrt( (population(1,:) - cir(1, y_max_index)).^2 + (population(2,:) - cir(2, y_max_index)).^2);
dis_b = sqrt( (population(1,:) - cir(1, y_min_index)).^2 + (population(2,:) - cir(2, y_min_index)).^2);

fitness = abs(dis_l - dis_r) + abs(dis_t - dis_b);