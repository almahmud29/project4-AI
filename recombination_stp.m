function children = recombination_stp(parents)

l_child = 50;   % create 50 child from 50 parent
children = zeros(50, 50);

for ii=1:2:l_child
    parent_1 = parents(:, 1, ii);
    parent_2 = parents(:, 1, ii+1);

    %%
%     sum(parent_1,1)
%     sum(parent_2,1)

    %%

    rand_int = 4;           % randi(5); % from 10 to 5
    rand_int_index = randi(30);

    % step 1
    children((rand_int_index:rand_int_index+rand_int-1),ii) = parent_1(rand_int_index:rand_int_index+rand_int-1);   % add -1
    children((rand_int_index:rand_int_index+rand_int-1),ii+1) = parent_2(rand_int_index:rand_int_index+rand_int-1);

    % step 2

    for i=rand_int_index:(rand_int_index+rand_int-1)
        Test = ismember (parent_2(i), parent_1(rand_int_index:(rand_int_index+rand_int-1)));
        if Test == 1
            % do nothing
        elseif Test == 0

            if parent_2(i) ~= parent_1(i)
                Check = ismember (parent_1(i), parent_2(rand_int_index:(rand_int_index+rand_int-1)));
                if Check == 0
                    ind = find(parent_2==parent_1(i)); % changed id to ind
                    children(ind,ii) = parent_2(i);
                elseif Check == 1
                    x = parent_1(i);
                    ind = find(parent_2==x);
                    yy = parent_1(ind);
                    id2 = find(parent_2==yy); % changed y to yy
                    children(id2,ii) = parent_2(i);
                end
            end
        end
    end

    for i=rand_int_index:(rand_int_index+rand_int-1)
        
        Test_2 = ismember (parent_1(i), parent_2(rand_int_index:(rand_int_index+rand_int-1)));
        if Test_2 == 1
            % do nothing
        elseif Test_2 == 0

            if parent_1(i) ~= parent_2(i)
                Check_2 = ismember (parent_2(i), parent_1(rand_int_index:(rand_int_index+rand_int-1)));
                if Check_2 == 0
                    ind = find(parent_1==parent_2(i));
                    children(ind,ii+1) = parent_1(i);
                elseif Check_2 == 1
                    x = parent_2(i);
                    ind = find(parent_1==x);
                    yy = parent_2(ind);
                    id2 = find(parent_1==yy);
                    children(id2,ii+1) = parent_1(i);
                end
            end
        end
    end
    
    % step 3
    for index=1:50
        if children(index,ii) == 0
            children(index,ii) = parent_2(index);
        end
        if children(index,ii+1) == 0
            children(index,ii+1) = parent_1(index);
        end
    end

end
