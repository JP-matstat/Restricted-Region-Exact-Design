%
%  optimization.m
%  optimization
%
%  Created by Johan Persson on 2017-06-19.
%  Copyright © 2017 Johan Persson. All rights reserved.
%

function [I_vec, M_vec, V] = optimization(s, N, shp, mdl, sim, pro)
tic
[I_vec, S, R, M_vec, ~] = alla(s, N, shp, mdl, sim, pro);
[r, k] = size(R);
Rold = R;

for i = 1:length(I_vec)
    I = I_vec(i);
    Iold = I - 1;
    M = M_vec{i};    
    switch k
        case 1
            R = [R(end,:); R; R(1,:)];
            while I > Iold
                Iold = I;
                for indexm = 1:N
                    Mm = M;
                    Mp = M;
                    for indexr = 2:r-1
                        if M(indexm,:) == R(indexr,:)
                            Mm(indexm,:) = R(indexr-1,:);
                            Mp(indexm,:) = R(indexr+1,:);
                            [Im, Mm] = information(Mm, mdl);
                            [Ip, Mp] = information(Mp, mdl);
                            if Im > I
                                I = Im;
                                M = Mm;
                            end
                            if Ip > I
                                I = Ip;
                                M = Mp;
                            end
                        end
                    end
                end
                I_vec(i) = I;
                M_vec{i} = M;
            end
        case 2
            while I > Iold
                Iold = I;
                R = Rold;
                R = [R(end,:); R; R(1,:)];
                for indexm = 1:N
                    Mm = M;
                    Mp = M;
                    for indexr = 2:r-1
                        if M(indexm,:) == R(indexr,:)
                            Mm(indexm,:) = R(indexr-1,:);
                            Mp(indexm,:) = R(indexr+1,:);
                            [Im, Mm] = information(Mm, mdl);
                            [Ip, Mp] = information(Mp, mdl);
                            if Im > I
                                I = Im;
                                M = Mm;
                            end
                            if Ip > I
                                I = Ip;
                                M = Mp;
                            end
                        end
                    end
                end
                expand = 0;
                R = Rold;
                while expand < s(2)
                    expand = expand + 1;
                    R = [R(end,:);R;R(1,:)];
                end
                [r_exp, k] = size(R);
                for indexm = 1:N
                    Mm = M;
                    Mp = M;
                    for indexr = 1+s(2):r_exp-s(2)
                        if M(indexm,:) == R(indexr,:)
                            Mm(indexm,:) = R(indexr-s(2),:);
                            Mp(indexm,:) = R(indexr+s(2),:);
                            [Im, Mm] = information(Mm, mdl);
                            [Ip, Mp] = information(Mp, mdl);
                            if Im > I
                                I = Im;
                                M = Mm;
                            end
                            if Ip > I
                                I = Ip;
                                M = Mp;
                            end
                        end
                    end
                end
                I_vec(i) = I;
                M_vec{i} = M;
            end
        case 3
            while I > Iold
                Iold = I;
                R = Rold;
                R = [R(end,:); R; R(1,:)];
                for indexm = 1:N
                    Mm = M;
                    Mp = M;
                    for indexr = 2:r
                        if M(indexm,:) == R(indexr,:)
                            Mm(indexm,:) = R(indexr-1,:);
                            Mp(indexm,:) = R(indexr+1,:);
                            [Im, Mm] = information(Mm, mdl);
                            [Ip, Mp] = information(Mp, mdl);
                            if Im > I
                                I = Im;
                                M = Mm;
                            end
                            if Ip > I
                                I = Ip;
                                M = Mp;
                            end
                        end
                    end
                end
                expand = 0;
                R = Rold;
                while expand < s(2)
                    expand = expand + 1;
                    R = [R(end,:);R;R(1,:)];
                end
                [r_exp, k] = size(R);
                for indexm = 1:N
                    Mm = M;
                    Mp = M;
                    for indexr = 1+s(2):r_exp-s(2)
                        if M(indexm,:) == R(indexr,:)
                            Mm(indexm,:) = R(indexr-s(2),:);
                            Mp(indexm,:) = R(indexr+s(2),:);
                            [Im, Mm] = information(Mm, mdl);
                            [Ip, Mp] = information(Mp, mdl);
                            if Im > I
                                I = Im;
                                M = Mm;
                            end
                            if Ip > I
                                I = Ip;
                                M = Mp;
                            end
                        end
                    end
                end
                expand = 0;
                R = Rold;
                while expand < r
                    expand = expand + 1;
                    R = [R(end,:);R;R(1,:)];
                end
                [r_exp, k] = size(R);
                for indexm = 1:N
                    Mm = M;
                    Mp = M;
                    for indexr = 1+r:r_exp-r
                        if M(indexm,:) == R(indexr,:)
                            Mm(indexm,:) = R(indexr-r,:);
                            Mp(indexm,:) = R(indexr+r,:);
                            [Im, Mm] = information(Mm, mdl);
                            [Ip, Mp] = information(Mp, mdl);
                            if Im > I
                                I = Im;
                                M = Mm;
                            end
                            if Ip > I
                                I = Ip;
                                M = Mp;
                            end
                        end
                    end
                end
                I_vec(i) = I;
                M_vec{i} = M;
            end
    end 
end
[Imax, index] = max(I_vec)
Mmax = M_vec{index};
V = show(M_vec{index},s);
toc
end
    
    
    
    
    
    
    
    
    
    
   
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

