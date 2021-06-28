function [Gi,Hi,Ei,Fi] = bj_step_pred(A,B,C,D,d,i)
% Systemmodell: y(k+1) = B/A u(k-d)+ X/Y e(k)
% Polynome Gi, Hi und Fi für die i-Schritt Prädiktion
% A = 1 + a_1 q^-1 + a_2 q^-2 + ... + a_na q^-na
% B = b_0 + b_1 q^-1 + ... + b_nb q^-nb
% C = c_0 + c_1 q^-1 + ... + c_nc q^-nc
% D = 1 + d_1 q^-1 + ... + d_nd q^-nd

[Ei, Fi] = dio_gl(C,D,i);
[Gi, Hi] = dio_gl(B,A,i-d+1);

end