function [design] = MtoD(M,S)

if isvector(S)
    S = S(:);
end

[rs, k] = size(S);
[rm, ~] = size(M);
design = zeros(rs,1);
        for j = 1:rs
            for i = 1:rm
                if S(j,:) == M(i,:)
                    design(j) = design(j) + 1;
                end
            end
        end

