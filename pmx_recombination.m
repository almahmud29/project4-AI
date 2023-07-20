function children_pmx = pmx_recombination(parents)

l_child = length(parents);
children_pmx = zeros(2, l_child);

for ii=1:2:l_child
    a_x = num2str(parents(1,ii))- '0';
    a_y = num2str(parents(2,ii))- '0';

    if a_x < 0
        sign_a_x = 0;
    else
        sign_a_x = 1;
    end

    if a_y < 0
        sign_a_y = 0;
    else
        sign_a_y = 1;
    end

    b_x = num2str(parents(1,ii+1))- '0';
    b_y = num2str(parents(2,ii+1))- '0';

    if b_x < 0
        sign_b_x = 0;
    else
        sign_b_x = 1;
    end

    if b_y < 0
        sign_b_y = 0;
    else
        sign_b_y = 1;
    end
    
    a_x(a_x < 0) = [];
    b_x(b_x < 0) = [];
    a_y(a_y < 0) = [];
    b_y(b_y < 0) = [];

    if length(a_x) < 5
        a_x = [a_x 0 0 0 0 0];
    end

    if length(a_y) < 5
        a_y = [a_y 0 0 0 0 0];
    end

    if length(b_x) < 5
        b_x = [b_x 0 0 0 0 0];
    end

    if length(b_y) < 5
        b_y = [b_y 0 0 0 0 0];
    end

    random_index = randperm(5,2);

    child_1_x = zeros(1,5);
    child_1_x(random_index(2)) = a_x(random_index(2));
    child_1_x(random_index(1)) = a_x(random_index(1));
    for index=1:length(child_1_x)
        if child_1_x(index) == 0
            child_1_x(index) = b_x(index);
        end
    end
    child_1_x = str2double(sprintf('%d',child_1_x))/10000;

    child_2_x = zeros(1,5);
    child_2_x(random_index(2)) = b_x(random_index(2));
    child_2_x(random_index(1)) = b_x(random_index(1));
    child_2_x = str2double(sprintf('%d',child_2_x))/10000;
    for index=1:length(child_2_x)
        if child_2_x(index) == 0
            child_2_x(index) = a_x(index);
        end
    end

    child_1_y = zeros(1,5);
    child_1_y(random_index(2)) = a_y(random_index(2));
    child_1_y(random_index(1)) = a_y(random_index(1));
    child_1_y = str2double(sprintf('%d',child_1_y))/10000;

    for index=1:length(child_1_y)
        if child_1_y(index) == 0
            child_1_y(index) = b_y(index);
        end
    end


    child_2_y = zeros(1,5);
    child_2_y(random_index(2)) = b_y(random_index(2));
    child_2_y(random_index(1)) = b_y(random_index(1));
    child_2_y = str2double(sprintf('%d',child_2_y))/10000;

    for index=1:length(child_2_y)
        if child_2_y(index) == 0
            child_2_y(index) = a_y(index);
        end
    end

    if sign_a_x ==0 || sign_b_x == 0
        child_1_x = child_1_x*(-1)
        child_2_x = child_2_x*(-1)
    end

    if sign_a_y ==0 || sign_b_y == 0
        child_1_y = child_1_y*(-1)
        child_2_y = child_2_y*(-1)
    end
    children_pmx(:,ii) = [child_1_x child_1_y];
    children_pmx(:,ii+1) = [child_2_x child_2_y];
%     children_pmx(:,ii) = [parents(1,ii) parents(2,ii+1)];
%     children_pmx(:,ii+1) = [parents(1,ii+1) parents(2,ii)];
end
