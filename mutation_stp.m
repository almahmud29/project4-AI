function children_mutation = mutation_stp(children_recom)


children_mutation = zeros(50,150);


% swap
for i=1:50
    child = children_recom(:,i);
    random_index = randperm(50,2);
    temp_1 = child;
    child(random_index(1)) = child(random_index(2));
    child(random_index(2)) = temp_1(random_index(1));
    
    children_mutation(:,i) = child;

end

% insert
for i=1:50
    child = children_recom(:,i);
    random_index = randperm(50,2);

    a_x = child;
    temp_1 = a_x;

    in = sort(random_index);
%     startPos = in(2);
%     numElements = 1;
    numElements = in(2) - in(1) - 1;
    oldElements = a_x(in(1)+1:in(1)+numElements); 
    temp_1(in(1)+1)=a_x(in(2));
%     temp_1(startPos-numElements:startPos-1)=a_x(startPos:startPos+numElements-1);

    temp_1(in(1)+2:in(1)+numElements+1)=oldElements;
    children_mutation(:,i+50) = temp_1;
end

% scramble
for i=1:50
    child = children_recom(:,i);
    random_index = randperm(50,2);
    temp_child = child;
    in = sort(random_index);
    temp_array = temp_child(in(1):in(2));
    Shuffle = temp_array(randperm(length(temp_array)));
    temp_child(in(1):in(2)) = Shuffle;
    children_mutation(:,i+100) = temp_child;
end
