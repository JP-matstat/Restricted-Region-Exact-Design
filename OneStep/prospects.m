%
%  prospects.m
%  prospects
%
%  Created by Johan Persson on 2017-06-19.
%  Copyright © 2017 Johan Persson. All rights reserved.
%

function [I_vec, S, R, M_vec, C] = prospects(s, N, shp, mdl, sim, pro)
I_vec = NaN(1,pro);
M_vec = cell(1,pro);
D_vec = cell(1,pro);
[S] = space(s);
[R,r] = region(S,shp);
for i = 1:pro
    [C,D] = design(N,r);
    [M] = matrix(D, R);
    [I, M] = information(M, mdl);
    I_vec(i) = I;
    M_vec{i} = M;
    D_vec{i} = D;
end   
I_min = min(I_vec);
for i = pro+1:sim
    [C,D] = design(N,r);
    [M] = matrix(D, R);
    [I, M] = information(M, mdl);
    if I > I_min
        [~, index] = min(I_vec);
        I_vec(index) = I;
        M_vec{index} = M;
        D_vec{index} = D;
        I_min = min(I_vec);
    end
end