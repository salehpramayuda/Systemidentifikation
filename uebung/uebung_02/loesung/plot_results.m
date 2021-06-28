load Theta_hat_vec

figure(1)
clf
subplot(3,2,1)
plot(Theta_hat_vec(1,:),Theta_hat_vec(2,:));hold on;
plot(Theta_hat_vec(1,:),ones(size(Theta_hat_vec(2,:)))*Theta(1));
ylim([0 0.5]);
title('Theta 1')
subplot(3,2,2)
plot(Theta_hat_vec(1,:),Theta_hat_vec(3,:));hold on;
plot(Theta_hat_vec(1,:),ones(size(Theta_hat_vec(2,:)))*Theta(2));hold on
ylim([0 100]);
title('Theta 2')
subplot(3,2,3)
plot(Theta_hat_vec(1,:),Theta_hat_vec(4,:));hold on
plot(Theta_hat_vec(1,:),ones(size(Theta_hat_vec(2,:)))*Theta(3));
ylim([0 0.5]);
title('Theta 3')
subplot(3,2,4)
plot(Theta_hat_vec(1,:),Theta_hat_vec(5,:));hold on
plot(Theta_hat_vec(1,:),ones(size(Theta_hat_vec(2,:)))*Theta(4));
ylim([0 20]);
title('Theta 4')
subplot(3,2,5)
plot(Theta_hat_vec(1,:),Theta_hat_vec(6,:));hold on
plot(Theta_hat_vec(1,:),ones(size(Theta_hat_vec(2,:)))*Theta(5));
ylim([0 0.02]);
title('Theta 5')
subplot(3,2,6)
plot(Theta_hat_vec(1,:),Theta_hat_vec(7,:));hold on
plot(Theta_hat_vec(1,:),ones(size(Theta_hat_vec(2,:)))*Theta(6));
title('Theta 6')
ylim([0 0.01]);
