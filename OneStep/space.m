function [S] = space(s)

d = length(s);
v = [];
for i = 1:d
    step = 2/(s(i)-1);
    t = -1:step:1;
    v = [v,t];
end
s1 = v(1:s(1));
switch d
    case 1
        S = s1;
    case 2
        s2 = v(s(1)+1:s(1)+s(2));
        S = allcomb(s1,s2);
    case 3
        s2 = v(s(1)+1:s(1)+s(2));
        s3 = v(s(1)+s(2)+1:end);
        S = allcomb(s1,s2,s3);
end
   