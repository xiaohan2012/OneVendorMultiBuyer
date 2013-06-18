%需要修改的数据 Start

N = 5;

D = [200 200 200 100 150]; %annual demand of buyer i with the item i 
A = [20 20 25 30 15]; %ordering cost per order of buyer i 
C_caret = [25 15 25 30 30]; %the unit purchase cost of buyer i 
r = 0.2;
r_caret = 0.2 .* ones(1, N); %the annual inventory holding cost per dollar invested in stocks of buyer i 
T0 = sqrt(2 .* A ./ (r_caret .* C_caret .* D)); %the optimal order interval for buyer 
S = 300; %the major setup cost for the vendor 
s = [100 80 100 90 150]; %the minor setup cost when item i is produced 
P = [320 300 250 300 300]; %the production rate of the vendor 
C = [20 10 15 25 20]; %vendor's unit production cost


%需要修改的数据 End


beta = ones(1, N) .* 1.1;
gamma = T0 .* (beta - sqrt(beta .^ 2 - 1));
theta = T0 .* (beta + sqrt(beta .^ 2 - 1));


%heuristic part
k = ones(1, N); %initialize all ks to 1

while 1
  a = max(gamma ./ k);
  a_caret = min(theta ./ k);
  
  m = floor(k .* (1 - D ./ P));
  
  %compute T value
  if a < a_caret
    T_caret = sqrt(2 .* (S + sum(s ./ max(k, 1))) / ( r .* sum(max(1, k) .* C .* D .* (1 + min(1, k) - D ./ P - 2 .* m ./ k))));
    T = min(max(a, T_caret), a_caret);
  else
    T = (a + a_caret) / 2;
  end

  current_k = ProcedureA(T, N, gamma, theta, r, C, D, P, s, m);

  if all(current_k == k) %stop iteration
    KT = k * T
    T
    break
  else
    k = current_k;%continue iteration
  end
    
end

