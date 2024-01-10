function [M] = matrix(D, R)

N = length(D);
for i = 1:N
    M(i,:) = R(D(i),:);
end
size(M);