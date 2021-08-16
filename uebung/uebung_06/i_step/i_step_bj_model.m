function [Ei,Fi,Gi,Hi]=i_step_bj_model(A,B,C,D,d,i)

[Ei,Fi] = i_step_prediction(C,D,i);
[Gi,Hi] = i_step_prediction(B,A,i-d+1);

end