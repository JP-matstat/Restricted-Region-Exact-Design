function [I, M] = information(M, model)

[N, d] = size(M);
A = ones(N,1);
Q1 = zeros(N,1);
Q2 = zeros(N,2);
Q3 = zeros(N,3);
I2 = zeros(N,1);
I3 = zeros(N,3);
C1 = zeros(N,1);
C2 = zeros(N,2);
C3 = zeros(N,3);
switch d
    case 1
        switch model
            case 1
                X = M;
            case 2
                X = [A, M];
            case 4
                for i = 1:N
                    Q1(i) = M(i,1)*M(i,1);
                end
                X = [A, M, Q1];
            case 5
                for i = 1:N
                    Q1(i) = M(i,1)*M(i,1);
                    C1(i) = Q1(i)*M(i,1);
                end
                X = [A, M, Q1, C1];
        end
    case 2
        switch model
            case 1
                X = M;
            case 2
                X = [A, M];
            case 3
                for i = 1:N
                    I2(i) = M(i,1)*M(i,2);
                end
                X = [A, M, I2];
            case 4
                for i = 1:N
                    I2(i) = M(i,1)*M(i,2);
                    Q2(i,1) = M(i,1)*M(i,1);
                    Q2(i,2) = M(i,2)*M(i,2);
                end
                X = [A, M, I2, Q2];
            case 5
                for i = 1:N
                    I2(i,1) = M(i,1)*M(i,2);
                    Q2(i,1) = M(i,1)*M(i,1);
                    Q2(i,2) = M(i,2)*M(i,2);
                    C2(i,1) = Q2(i,1)*M(i,1);
                    C2(i,2) = Q2(i,2)*M(i,2);
                end
                X = [A, M, I2, Q2, C2];
        end
    case 3
        switch model
            case 1
                X = M;
            case 2
                X = [A, M];
            case 3
                for i = 1:N
                    I3(i,1) = M(i,1)*M(i,2);
                    I3(i,2) = M(i,1)*M(i,3);
                    I3(i,3) = M(i,2)*M(i,3);
                end
                X = [A, M, I3];
            case 4
                for i = 1:N
                    I3(i,1) = M(i,1)*M(i,2);
                    I3(i,2) = M(i,1)*M(i,3);
                    I3(i,3) = M(i,2)*M(i,3);
                    Q3(i,1) = M(i,1)*M(i,1);
                    Q3(i,2) = M(i,2)*M(i,2);
                    Q3(i,3) = M(i,3)*M(i,3);
                end
                X = [A, M, I3, Q3];
            case 5
                for i = 1:N
                    I3(i,1) = M(i,1)*M(i,2);
                    I3(i,2) = M(i,1)*M(i,3);
                    I3(i,3) = M(i,2)*M(i,3);
                    Q3(i,1) = M(i,1)*M(i,1);
                    Q3(i,2) = M(i,2)*M(i,2);
                    Q3(i,3) = M(i,3)*M(i,3);
                    C3(i,1) = Q3(i,1)*M(i,1);
                    C3(i,2) = Q3(i,2)*M(i,2);
                    C3(i,3) = Q3(i,3)*M(i,3);
                X = [A, M, I3, Q3, C3];
                end
        end
end
I = det(X'*X);