%Polynome in q^-1
A = [1 -1.6 0.64] % 1-1.6*q^(-1)+0.64*q^(-2)
B = [0 0 0.15]
C = 1;

P_0 = eye(3,3)*1;
lambda=0.995;
alpha=1;
Theta_hat_0=[0 0 0]';
K=200; %Number of samples used for initial LS / should be larger than 3