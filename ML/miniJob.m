function [S] = miniJob(mvMatrix, F, lambda)

    num = size(mvMatrix{1}, 1);
    viewNum = size(mvMatrix, 2);
    
    S = zeros(num); % S is the optimal matrix to be learned         
    distd = L2_distance_1(F', F');
    for i = 1:num
        a0 = zeros(1, num);
        for v = 1:viewNum
            temp = mvMatrix{v};
            a0 = a0 + 1 / viewNum * temp(i, :);
        end
           
        idxa0 = find(a0 > 0);
        ai = a0(idxa0);
        di = distd(i, idxa0);         
        ad = (ai - 0.5 * lambda * di);
        S(i, idxa0) = EProjSimplex(ad);
    end
       
end


   