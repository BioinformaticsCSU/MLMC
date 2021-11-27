function [SR, SD, F] = MultiViewPrediction(AR, AD, A, lamdaR, lamdaD)

% credit to Liang et al.

    NITER = 50;
    thresh = 10^-10;
    
    F_old = A;
    F = A;
    SR = zeros(size(AR{1}));
    SD = zeros(size(AD{1}));
    
    for iter = 1:NITER
        
        SR = miniJob(AR, F, lamdaR);
        SD = miniJob(AD, F', lamdaD);

        SR0 = SR - diag(diag(SR));
        SR1 = (SR0 + SR0') / 2; 
        DR = diag(sum(SR1));
        idR = eye(size(SR1, 1));
        SR2 = diag(1 ./ diag(sqrtm(DR)));
        LSR = idR - SR2 * SR1 * SR2;
        

        SD0 = SD - diag(diag(SD));
        SD1 = (SD0 + SD0') / 2; 
        DD = diag(sum(SD1));
        idD = eye(size(SD1, 1));
        SD2 = diag(1 ./ diag(sqrtm(DD)));
        LSD = idD - SD2 * SD1 * SD2;
        
        F = sylvester(2 * lamdaR * LSR + idR, 2 * lamdaD * LSD, A);
        
        diff = abs(sum(sum(abs(F) - abs(F_old))));
        if diff < thresh
            % fprintf('Iteration stops at %d step.\n', iter);
            break;
        end
        
        F_old = F;
        
    end
end


   