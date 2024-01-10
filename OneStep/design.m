function [C,D] = design(N,r)
D = zeros(N,1);
for i = 1:N
    D(i) = randi(r);
end
D = sort(D);
C = zeros(r,1);
for i = 1:N
   C(D(i)) = C(D(i))+1;
end




