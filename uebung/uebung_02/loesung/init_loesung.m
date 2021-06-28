Theta=[0.25 50 0.25 10 0.01 0.0045]';
xdash0=[1000 550 0.0001]';
xdash12RL=[1000 550]';
Delta = 0.01;

%%Solution 
%x_hat_0,P,Z,W
pp=0.3;
a=Theta-Theta*pp;
b=Theta+Theta*pp;
Theta_hat_0 = a + (b-a).*rand(6,1);
a=xdash0-xdash0*pp;
b=xdash0+xdash0*pp;
xdash_hat_0 = a + (b-a).*rand(3,1);
x_hat_0=[xdash_hat_0;Theta_hat_0];
P_0=diag([(xdash0*pp).^2;(Theta*pp).^2]);
W=zeros(9,9);
%W(5,5)=0.001; 
Z = diag([100,100,10^-5]);


 
