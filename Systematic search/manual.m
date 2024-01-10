function [M, I] = manual(s, shape, N, C, model)
if sum(C) ~= N 
    disp('N inte summan av C:s element')
end
S = space(s);
R = region(S,shape);
[r, ~]=size(R);
v = 1:r;

D = repelem(v, C);
M = matrix (D, R);
I = information (M, model);


