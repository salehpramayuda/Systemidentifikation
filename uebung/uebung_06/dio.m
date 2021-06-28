function [Ei, Fi] = dio(X, Y, i)
    syms q q_1
    if isnumeric(X)
        x = X;
    else
        x = coeffs(X); % Polynome zu Matrizen
    end
    E_j = x(1);
    F_j = q*(X-x(1)*Y);
    j = 1;
    
    while j~=i
        f = coeffs(F_j);  % Polynome zu Matrizen
        e_j1 = f(1);
        E_j1 = E_j + e_j1*q_1;
        F_j1 = q * (F_j - Y*f(1));
        j = j+1;
        
        E_j = E_j1;
        F_j = F_j1;
    end

    F_j = matlabFunction(F_j);  % q mit 1/q_1 ersetzen
    Ei = E_j;
    Fi = F_j(1/q_1, q_1);
    
    if ~isnumeric(Ei)
        Ei = simplify(Ei);
    end
    if ~isnumeric(Fi)
        Fi = simplify(Fi);
    end
end

