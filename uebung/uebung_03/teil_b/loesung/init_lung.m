R=50;%cmH2O/L/s
C=0.02;%L/cmH2O
V0=2;
Pinsp=20;
PEEP=5;
p0=(V0-C*PEEP)/(-C);
Ti=2;
Te=2;
Delta=0.01
fn=(1/Delta)/2;
%[B,A] = butter(3,[10/fn],'low');

R0=10;
C0=0.01;

t=-1:0.01:15;
n=25;
o=0.1;m=[linspace(0,Ti, n) linspace(Ti+Te,Ti+Te+Ti, n)]';
n=n*2;
i=1;
rbf_data.m=m(1:n/2);
rbf_data.n=n/2;
rbf_data.o=o;
w_mat=zeros(n,length(t));
rho_mat=zeros(n,length(t));
for tt=t
    w_mat(:,i)=exp(-1/2*(((tt)*ones(length(m),1)-m)./o).^2);
    rho_mat(:,i)=w_mat(:,i)/sum(w_mat(:,i));
    i=i+1;
end
figure(1)
plot(t',w_mat);
xlim([-1 7]);
ylim([-0.2 1.2]);
grid
xlabel('Zeit in s','interpreter','latex','fontsize',14);
ylabel('$w_i$','interpreter','latex','fontsize',14);
title('Periodische Gaußfunktionen','interpreter','latex','fontsize',14)
print -deps2c gf.eps

tt=0:0.01:Ti;
yy=sin(2*pi/(Ti)*tt+pi*3/2)+1;


figure(2);clf;plot(tt,yy);

figure(2)
subplot(2,1,1)
plot(0.2+[[0 Ti/8 Ti Ti+0.01 Ti+Te].' Ti+Te+[0 Ti/8 Ti Ti+0.01 Ti+Te].' ... 
    2*Ti+2*Te+[0 Ti/8 Ti Ti+0.01 Ti+Te].'],...
    [[PEEP Pinsp Pinsp PEEP PEEP]' [PEEP Pinsp Pinsp PEEP PEEP]'...
    [PEEP Pinsp Pinsp PEEP PEEP]'],'b');
ylabel('$p_{\mathrm{AW}}(t)$','interpreter','latex','fontsize',14);
grid on;
ylim([0 25]);
xlim([0 12]);
subplot(2,1,2)
plot([[tt Ti+Te] Ti+Te+[tt Ti+Te] (2*Ti+2*Te)+[tt Ti+Te]],[[5*yy 0] [5*yy 0] [5*yy 0]]'.*[(sin(2*pi*0.1*[[tt Ti+Te] Ti+Te+[tt Ti+Te] (2*Ti+2*Te)+[tt Ti+Te]])*0.5+0.5)]','b');
ylabel('$-p_{\mathrm{Pl}}(t)$','interpreter','latex','fontsize',14);
grid on
xlabel('Zeit in s','interpreter','latex','fontsize',14);
ylim([-2 12]);
print -deps2c inputs.eps

