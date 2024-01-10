function [I,V,Mny] = jmfr(M,s)

[r,k] = size(M);
ettor = ones(r,1);
utv = zeros(r,1);
for i = 1:r
utv(i) = M(i,1)*M(i,2);
end
utv = utv';
Mny = [ettor,M,utv'];
V = show(M,s);
I = det(Mny'*Mny);