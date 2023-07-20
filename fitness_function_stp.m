function fitness = fitness_function_stp(M)


% M = zeros(50,3,100);
% for k=1:100
%     for i=1:50
%         for j=1:50
%             if city_all(i,1) == population(j,k)
%                 M(j,2:3,k) = city_all(i,2:3);
%                 M(j,1,k) = population(j,k);
%             end
%         end
%     end
% end
%%
% calculate distance of each route
x_M = length(M);    % renamed from x to x_M
% Total_distamce = zeros(100,1);
Total_distamce = zeros(x_M,1);

% for kk=1:100
for kk=1:x_M
    for ii=1:49
        d = norm(M(ii,2:3,kk) - M(ii+1,2:3,kk));    % distence between two cities     
        Total_distamce(kk) = Total_distamce(kk) + d;    % Total distance for kk'th route
    end
end

fitness = Total_distamce;





