function [G, H, F] = make_matrix(A, B, C, D, Hp, Hs, d)
 l = Hp-d+1;
 deg_A = length(A)-1;
 deg_D = length(D)-1;
 G = zeros(Hp-Hs+1,l);
 H = zeros(Hp-Hs+1,deg_A);
 F = zeros(Hp-Hs+1,deg_D);
 for i = Hs: Hp
     [Gi, Hi] = dio_loes(B,A,i-d+1);
     [~, Fi] = dio_loes(C,D,i);
     for j = 1:deg_D
         F(i,j) = Fi(j);
     end
     for j = 1:deg_A
         H(i,j) = Hi(j);
     end
     for j = 1:l
         if j<=length(Gi)
             G(i,j) = Gi(j);
         else
             G(i,j) = 0;
         end
     end
 end
 G = G(Hs:end,:); F = F(Hs:end,:); H = H(Hs:end,:);
end