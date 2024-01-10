function [R,r] = region(S,shape)

[n, ~] = size(S);
j = 0;
R = [];
switch shape
    case 1
        R = S;
    case 2
        for i = 1:n
            if ~(all(S(i,:)>0))
                R(i-j,:) = S(i,:);
            else j = j + 1;
            end
        end
    case 3
        for i = 1:n
            if sum(S(i,:))<=1
                R(i-j,:) = S(i,:);
            else j = j + 1;
            end
        end
end

[r, k] = size(R);
if r == 1
    R = R(:);
    r = k;
end

