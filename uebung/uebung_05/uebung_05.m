% Übung 05 Strukturbestimmung
% Essentiell: VL6: Modellvalidierung, VL4: Dynamische Systeme
clc; clear;
%% Load & Datenvorbereitung
load('m2.mat')
t = io_data(1,:)'; u = io_data(2,:)'; y = io_data(3,:)';
ratio = 7/9;
ind_val = round(length(t)*ratio);
data_est = iddata(y(1:ind_val-1), u(1:ind_val-1), t(2)-t(1));
data_val = iddata(y(ind_val:end), u(ind_val:end), t(2)-t(1));

index = t(end)*ratio;
index_est = find((t>=0)&(t<=index));
index_val = find((t>index)&(t<=t(end)));
u_mean = (max(u)+min(u))/2;
y_mean = mean(y);
y_std = std(y);
u_std = std(u);
y_norm = (y-y_mean)/y_std;
u_norm = (u-u_mean)/u_std;

Ts = t(2)-t(1);
data_est = iddata(y_norm(index_est), u_norm(index_est), Ts);
data_val = iddata(y_norm(index_val), u_norm(index_val), Ts);

%% BJ Model start
d = 0;
n_max = 3;
bj_m1 = bj(data_est, [n_max, n_max, n_max, n_max, d]);

% d bestimmen
while(round(bj_m1.B(d+1), 1)==0)
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
bj_m1 = bj(data_est, [nb, nd, nc, na, d]);
ar_m1 = armax(data_est, [na, nb, nc, d]);
oe_m1 = oe(data_est, [nb, na, d]);

    
    