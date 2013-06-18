function K = ProcedureA(T, N, gamma, theta, r, C, D, P, s)
    K = zeros(N, 1);
    StepOneVals = 1 / floor(T / gamma);
    StepOnePredicates = theta / T <= 1;
    K(StepOnePredicates) = StepOneVals(StepOnePredicates);
    
    k_upperline = zeros(N, 1);
    for i = 1:N
        if StepOnePredicates(i) == 1 %if case one, ignore
            continue
        end
        
        %calculating caret k 
        k_caret = 1;
        while true
            value = 2 * s(i) * P(i) / (T^2 * r * C(i) * D(i) * (2*P(i) - D(i)));
            if value > k_caret * (k_caret - 1) && value <= k_caret * (k_caret + 1)
                break
            end
            k_caret = k_caret + 1;
        end
        
        %calculating upperline k 
        k_upperline(i) = min(k_caret, floor(theta(i) / t));
        
        %calculating set G
        l = 1
        LowerBound = k_upperline;
        UpperBound = floor(theta(i) / T);
        ys = [];
        while true
            y = l * P(i) / (P(i) - D(i));
            if y > LowerBound
                if y <= UpperBound
                    ys = [ys y];
                else
                    break;
                end
            end            
        end
        G = [ys k_upperline];
        
        %calculating set caret G
        if gamma(i) / T >= 1
            G_caret = G;
        else
            G_caret = [G 1 / floor(T/gamma(i))];
        end
        
        %find the element in G that minimize 'f'
        f_k = s(i) / (T .* G_caret) + r * T .* G_caret * C(i) * D(i) * (2 - D(i) / P(i)); %r * T * C(i) * D(i) * m(i) can be omitted
        [minVal, minIndex] = min(f_k); %find the min
        
        K(i) = G_caret(minIndex);
    end
end