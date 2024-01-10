%
%  show.m
%  show
%
%  Created by Johan Persson on 2017-06-19.
%  Copyright © 2017 Johan Persson. All rights reserved.
%

function [V] = show(M,s)

S = space(s);
[d] = MtoD(M,S);
[d_mat] = d_to_d_mat(d,s);
V = d_mat;