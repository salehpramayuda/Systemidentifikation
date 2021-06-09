% Übung 02
init
simulinkFilename = './hiv_model_ekf';
systemModel = load_system(simulinkFilename);
modelConfigSet = getActiveConfigSet(systemModel);
modelConfig = modelConfigSet.copy;

% Simulation für Aufgabe 4
simResult = sim(simulinkFilename, modelConfig);
simdata = simResult.simout; %1-2: CD4, 3-4: CD8, 5-6: Viren, 7-12: Parameter
t = simResult.tout;
a = ones(size(simdata(:,7)));

figure();clf
for i = 1:6
   subplot(3,2,i); hold on; grid on;
   plot(t, a*Theta(i), 'r', 'LineWidth', 2);
   plot(t, simdata(:,6+i)', 'b');
   ylabel(['\Theta_',num2str(i)]);
   legend('Wahr', 'EKF');
end

% subplot(2,1,1);hold on; grid on;
% plot(t, a*Theta(1), 'r', 'LineWidth', 3.5);
% plot(t, a*Theta(2), 'b', 'LineWidth', 2);
% plot(t, a*Theta(3), 'g', 'LineWidth', 2);
% plot(t, simdata(:,7)','Color',[0.5 0.1 0.7], 'LineWidth', 0.8);
% plot(t, simdata(:,8)','Color',[0.7 0.3 0.2], 'LineWidth', 0.8);
% plot(t, simdata(:,9)','Color',[0 0 0], 'LineWidth', 0.8);
% legend('\Theta_{1,wahr}','\Theta_{2,wahr}','\Theta_{3,wahr}',...
%     '\Theta_1','\Theta_2','\Theta_3');
% hold off
% 
% subplot(2,1,2);hold on; grid on;
% plot(t, a*Theta(4), 'r', 'LineWidth', 2);
% plot(t, a*Theta(5), 'b', 'LineWidth', 3.5);
% plot(t, a*Theta(6), 'g', 'LineWidth', 2);
% plot(t, simdata(:,10)','Color',[0.5 0.1 0.7], 'LineWidth', 0.8);
% plot(t, simdata(:,11)','Color',[0.7 0.3 0.2], 'LineWidth', 0.8);
% plot(t, simdata(:,12)','Color',[0 0 0], 'LineWidth', 0.8);
% legend('\Theta_{4,wahr}','\Theta_{5,wahr}','\Theta_{6,wahr}',...
%     '\Theta_4','\Theta_5','\Theta_6');
% hold off

exportgraphics(gcf, 'parameter_1.pdf', 'ContentType', 'Vector');