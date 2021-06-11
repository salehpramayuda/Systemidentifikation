% Übung 05 Strukturbestimmung
% Essentiell: VL6: Modellvalidierung, VL4: Dynamische Systeme
clc; clear;
%% Load & Datenvorbereitung

ratio = [50, 50];
disp(['Ratio ', num2str(ratio(1)),':',num2str(ratio(2))])

for i=1:4
    load(['m', num2str(i), '.mat'])
    t = io_data(1,:)'; u = io_data(2,:)'; y = io_data(3,:)';
    ratio = 1/2;
    ind_val = round(length(t)*ratio);
    data_est = iddata(y(1:ind_val-1), u(1:ind_val-1), t(2)-t(1));
    data_val = iddata(y(ind_val:end), u(ind_val:end), t(2)-t(1));

    %% BJ Model start
    d = 0;
    n_max = 3;
    bj_m1 = bj(data_est, [n_max, n_max, n_max, n_max, d]);

    % d bestimmen
    while(round(bj_m1.B(d+1), 1)==0)
        d = d+1;
    end

    t_lsim = data_val.SamplingInstants-...
            data_val.SamplingInstants(1);

    %% n_A bestimmen
    fit_hist = zeros(1,n_max);
    for na = 1:n_max
        bj_m1 = bj(data_est, [na, n_max, n_max, na, d]);
%         y_hat = lsim(bj_m1, data_val.u, t_lsim);
%         fit_hist(na) = 100*(1-goodnessOfFit(y_hat,data_val.y,'NMSE'));
        [~, fit_hist(na), ~] = compare(data_val, bj_m1, 100);
    end
    [~, na] = max(fit_hist);

    %% n_B bestimmen
    fit_hist = zeros(1,n_max+1);
    for nb = 0:na
        bj_m1 = bj(data_est, [nb, n_max, n_max, na, d]);
%         y_hat = lsim(bj_m1, data_val.u, t_lsim);
%         fit_hist(nb+1) = 100*(1-goodnessOfFit(y_hat,data_val.y,'NMSE'));
        [~, fit_hist(nb+1), ~] = compare(data_val, bj_m1, 100);
    end
    [~, nb] = max(fit_hist); nb=nb-1;

    %% n_C und n_D
    fit_hist = zeros(1,n_max+1);
    for nc = 0:n_max
        bj_m1 = bj(data_est, [nb, nc, nc, na, d]);
%         y_hat = lsim(bj_m1, data_val.u, t_lsim);
%         fit_hist(nc+1) = 100*(1-goodnessOfFit(y_hat,data_val.y,'NMSE'));
        [~, fit_hist(nc+1), ~] = compare(data_val, bj_m1, 100);
    end
    [~, nc] = max(fit_hist); nc=nc-1;
    nd = nc;
    
    bj = bj(data_est, [nb, nd, nc, na, d]);
    ar = armax(data_est, [na, nb, nc, d]);
    oe = oe(data_est, [nb, na, d]);

    disp(['m:', num2str(i), '  na:', num2str(na), '  nb:', num2str(nb), ...
          '  nc:', num2str(nc), '  nd:', num2str(nd), '  d:', num2str(d)])
    disp(['A:  ', num2str(bj.F)])
    disp(['B:  ', num2str(bj.B)])  
    disp(['C:  ', num2str(bj.C)])  
    disp(['D:  ', num2str(bj.D)])
    disp(' ')

    figure(1)
    subplot(2, 2, i)
    compare(data_val, bj, ar, oe, 100)
    title(['m', num2str(i)])
    clear
end