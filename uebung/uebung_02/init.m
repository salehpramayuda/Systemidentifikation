Theta=[0.25 50 0.25 10 0.01 0.0045]';
xdash0=[1000 550 0.0001]';
xdash12RL=[1000 550]';
Delta = 0.01;

% Für EKF
%theta0=(1+0.3*(1-2*rand(6,1))).*Theta;
W_k=zeros(9,9);
%W_k = [eye(3),zeros(3,6);zeros(6,9)];
%P_0=0.3*eye(9);P_0(1,1)=1;P_0(2,2)=1;P_0(3,3)=1;
P_0 = [diag((Theta*0.3).^2),zeros(6,3);zeros(3,9)];

Z_k=zeros(3,3);Z_k(1,1)=100;Z_k(2,2)=100;Z_k(3,3)=1e-5;


     
       



