function [V] = show(M,s)

S = space(s);
[d] = MtoD(M,S);
[d_mat] = d_to_d_mat(d,s);
V = d_mat;