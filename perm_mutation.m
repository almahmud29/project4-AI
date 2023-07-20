function children = perm_mutation(children_recom, pm)

l_cr = length(children_recom);
shuffle_seq = randperm(l_cr);
stop_index = fix(l_cr*pm);

children = children_recom;

for ii = 1:stop_index
    a_x = num2str(children(1, shuffle_seq(ii)))- '0';
    a_y = num2str(children(2, shuffle_seq(ii)))- '0';

    
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

    a_x(a_x < 0) = [];
%     b_x(b_x < 0) = [];
    a_y(a_y < 0) = [];
%     b_y(b_y < 0) = [];

    if length(a_x) < 5
        a_x = [a_x 0 0 0 0 0];
    end

    if length(a_y) < 5
        a_y = [a_y 0 0 0 0 0];
    end

    a_x = a_x(1:5);
    a_y = a_y(1:5);

    fixed_ax = a_x;
    fixed_ay = a_y;

    random_index = randperm(5,2);
    

    % swap
    temp_1 = a_x;
    a_x(random_index(1)) = a_x(random_index(2));
    a_x(random_index(2)) = temp_1(random_index(1));

    temp_2 = a_y;
    a_y(random_index(1)) = a_y(random_index(2));
    a_y(random_index(2)) = temp_2(random_index(1));

    children(1, shuffle_seq(ii)) = str2double(sprintf('%d',a_x))/10000;
    children(2, shuffle_seq(ii)) = str2double(sprintf('%d',a_y))/10000;

    % insert
    a_x = fixed_ax;
    temp_1 = a_x;

    in = sort(random_index);
    startPos = in(2);
    numElements = 1;
    oldElements = a_x(startPos-numElements:startPos-1); 
    temp_1(startPos-numElements:startPos-1)=a_x(startPos:startPos+numElements-1);
    temp_1(startPos:startPos+numElements-1)=oldElements;

    a_y = fixed_ay;
    temp_2 = a_y;

    startPos = in(2);
    numElements = 1;
    oldElements = a_y(startPos-numElements:startPos-1); 
    temp_2(startPos-numElements:startPos-1)=a_y(startPos:startPos+numElements-1);
    temp_2(startPos:startPos+numElements-1)=oldElements;

    children(1, shuffle_seq(ii)+26) = str2double(sprintf('%d',temp_1))/10000;
    children(2, shuffle_seq(ii)+26) = str2double(sprintf('%d',temp_2))/10000;

    % scramble

    a_x = fixed_ax;
    a_y = fixed_ay;

    a_x(randperm(length(a_x)));
    a_y(randperm(length(a_y)));

    children(1, shuffle_seq(ii)+26*2) = str2double(sprintf('%d',a_x))/10000;
    children(2, shuffle_seq(ii)+26*2) = str2double(sprintf('%d',a_y))/10000;





% 
%     temp_1 = a_x;
%     a_x(random_index(1) + 1) = a_x(random_index(2));
%     for i=(random_index(1) + 1):length(temp_1)
%         if i == random_index(2)
%             % do nothing
%         else
%             a_x(i+1) = temp_1(i)
%         end
% 
%     end
% 
%     temp_2 = a_y;
%     a_y(random_index(1) + 1) = a_y(random_index(2));
%     for i=(random_index(1) + 1):length(temp_2)
%         if i == random_index(2)
%             % do nothing
%         else
%             a_y(i+1) = temp_2(i)
%         end
% 
%     end
%     a_x(random_index(2)) = temp_1(random_index(1));

%     children(:, shuffle_seq(ii)) = children(:, shuffle_seq(ii));
end

