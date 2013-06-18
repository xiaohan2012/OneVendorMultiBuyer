N = 10;

%global D A C_ex r_ex T0 T kT S s P C beta gamma theta;

D = ones(N, 1); %annual demand of buyer i with the item i 
A = ones(N, 1); %ordering cost per order of buyer i 
C_ex = ones(N, 1); %the unit purchase cost of buyer i 
r_ex = ones(N, 1); %the annual inventory holding cost per dollar invested in stocks of buyer i 
T0 = sqrt(2 .* A ./ (r_ex .* C_ex .* D)); %the optimal order interval for buyer 
T = 1; %the vendor setup time interval 
kT = ones(N, 1); %buyer i purchasing time interval after negotiation    k¡Ê(1, 1/2, 1/3¡­¡­)¡È(1,2,3¡­¡­) 
S = 1; %the major setup cost for the vendor 
s = ones(N, 1); %the minor setup cost when item i is produced 
P = 1; %the production rate of the vendor 
C = 1; %vendor¡¯s unit production cost

beta = ones(N, 1);
gamma = T0 .* (beta - sqrt(beta .^ 2 - 1));
theta = T0 .* (beta + sqrt(beta .^ 2 - 1));

%heuristic part
k = ones(N, 1);
a = max(gamma ./ k);
a_caret = min(theta ./ k);

if a < a_caret
    T_caret = sqrt(2 * (S + sum(s/max(k, 1))) / ( r * sum(max(1, k) .* C .* D (1 + min(1, k) - D ./ P - 2 * m ./ k))));
end
k = ProcedureA(T, N, gamma, theta, r, C, D, P, s)

