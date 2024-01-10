function [d_mat,ds3] = d_to_d_mat(d,s)

switch length(s)
    case 1
        d_mat = d;
    case 2
        d_mat = vec2mat(d,s(2));
        d_mat = d_mat';
        d_mat = flipud(d_mat);
    case 3
        rader = s(1)*s(2);
        ds3 = zeros(rader,s(3));
        for k = 1:s(3)
                ds3(:,k) = d(k:s(3):end);
        end
        d_mat = ds3;
        d_mat = zeros(s(1),s(2),s(3));
        for k = 1:s(3)
                d_mat(:,:,k) = vec2mat(ds3(:,k),s(2));       
        end
        d_mat = permute(d_mat,[2 1 3]);
        d_mat = flipud(d_mat);
end
            