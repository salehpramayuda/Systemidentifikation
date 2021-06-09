% Übung 06 Strukturbestimmung
% Essentiell: VL6: Modellvalidierung, VL4: Dynamische Systeme
clc; clear;
%% Load & Datenvorbereitung
load('matlab_examples/m1')
t = io_data(1,:)'; u = io_data(2,:)'; y = io_data(3,:)';
[~, ind_val] = min(abs(t-t(end)*7/9));

data_est = iddata(y(1:ind_val-1), u(1:ind_val-1), t(2)-t(1));
data_val = iddata(y(ind_val:end), u(ind_val:end), t(2)-t(1));

%% BJ Model start
d = 0;
n_max = 3;
bj_m1 = bj(data_est, [n_max, n_max, n_max, n_max, d]);

% d bestimmen
while(bj_m1.B(d+1)==0)
    d = d+1;
end

%% n_A bestimmen
fit_hist = zeros(1,n_max);
for na = 1:n_max
    bj_m1 = bj(data_est, [na, n_max, n_max, na, d]);
    y_hat = lsim(bj_m1, data_val.u, data_val.SamplingInstants-...
        data_val.SamplingInstants(1));
    fit_hist(na) = 100*(1-goodnessOfFit(y_hat,data_val.y,'NRMSE'));
end

[~, na] = max(fit_hist);

%% n_B bestimmen
fit_hist = zeros(1,n_max+1);
for nb = 0:na
    bj_m1 = bj(data_est, [nb, n_max, n_max, na, d]);
    y_hat = lsim(bj_m1, data_val.u, data_val.SamplingInstants-...
        data_val.SamplingInstants(1));
    fit_hist(nb+1) = 100*(1-goodnessOfFit(y_hat,data_val.y,'NRMSE'));
end

[~, nb] = max(fit_hist); nb=nb-1;

%% n_C und n_D
fit_hist = zeros(1,n_max+1);
for nc = 0:n_max
    bj_m1 = bj(data_est, [nb, nc, nc, na, d]);
    y_hat = lsim(bj_m1, data_val.u, data_val.SamplingInstants-...
        data_val.SamplingInstants(1));
    fit_hist(nc+1) = 100*(1-goodnessOfFit(y_hat,data_val.y,'NRMSE'));
end

[~, nc] = max(fit_hist); nc=nc-1;
nd = nc;
    
    
    
    