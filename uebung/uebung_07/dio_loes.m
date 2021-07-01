function [Ei, Fi] = dio_loes(X, Y, i)
% Y ist monisch : Y = 1 + y_1q^-1 + ... + y_ny q^-ny
%
deg_X = length(X)-1;
deg_Y = length(Y)-1;
for j = 1:i
    if(j==1)
        Ei = X(1);
        if(length(X)>length(Y))
            X_erw = X;
            Y_erw = [Y, zeros(1,deg_X-deg_Y)];
        else
            Y_erw = Y;
            X_erw = [X, zeros(1,deg_Y-deg_X)];
        end
        Fi = zeros(1,length(X_erw)-1);
        for i=1:length(X_erw)-1
            Fi(i) = X_erw(i+1)-X_erw(1)*Y_erw(i+1);
        end
    else
        % Grad E bestimmen
        if deg_Y>0
            deg_E = j-1;
        else
            deg_E = min([j-1, deg_X]);
        end
        % Grad F bestimmen
        deg_F = max([-j+deg_X, deg_Y-1]);
        % Rekursive Aufruf

        Ei(deg_E+1) = Fi(1);
        %Fi(deg_F+1) = 0;
        for l = 1:deg_F
            Fi(l) = Fi(l+1)-Y(l+1)*Ei(end);
        end
        Fi(deg_F+1) = -Y(deg_F+2)*Ei(end);
    end
end
% 
% 
% if(i~=1)
%     Grad E bestimmen
%     if deg_Y>0
%         deg_E = i-1;
%     else
%         deg_E = min([i-1, deg_X]);
%     end
% 
%     Grad F bestimmen
%     deg_F = max([-i+deg_X, deg_Y-1]);
%     
%     Rekursive Aufruf
%     [E_im1, F_im1] = dio_gl(X, Y, i-1);
%     
%     Ei = [E_im1, F_im1(1)];
%     F_im1 = [F_im1, 0];
%     Fi = zeros(1, deg_F+1);
%     for i = 1:deg_F+1
%         Fi(i) = F_im1(i+1)-Y(i+1)*F_im1(1);
%     end
% else
%     Ei = X(1);
%     if(length(X)>length(Y))
%         X_erw = X;
%         Y_erw = [Y, zeros(1,deg_X-deg_Y)];
%     else
%         Y_erw = Y;
%         X_erw = [X, zeros(1,deg_Y-deg_X)];
%     end
%     Fi = zeros(1,length(X_erw)-1);
%     for i=1:length(X_erw)-1
%         Fi(i) = X_erw(i+1)-X_erw(1)*Y_erw(i+1);
%     end
% end
% 
% Null entfernen
% i = length(Ei);
% nz = 0;
% while(Ei(i)==0 && i>0)
%     nz = nz +1;
%     i = i-1;
% end
% if nz~=0
%     E = zeros(1, length(Ei)-nz);
%     for i = 1:length(Ei)-nz
%         E(i) = Ei(i);
%     end
%     Ei = E;
% end
% i = length(Fi);
% nz = 0;
% while(Fi(i)==0 && i>0)
%     nz = nz +1;
%     i = i-1;
% end
% if nz~=0
%     F = zeros(1, length(Fi)-nz);
%     for i = 1:length(Fi)-nz
%         F(i) = Fi(i);
%     end
%     Fi = F;
% end



end