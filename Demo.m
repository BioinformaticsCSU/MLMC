clear all
addpath('dataset');
addpath('ML');
addpath('MC');

%% Load datesets
load Fdataset_ms
Wrr1 = drug_ChemS;
Wrr2 = drug_AtcS;
Wrr3 = drug_SideS;
Wrr4 = drug_DDIS;
Wrr5 = drug_TargetS;
Wdd1 = disease_PhS;
Wdd2 = disease_DoS;
Wdr = didr;
Wrd = Wdr';

alphaBMC = 10; 
betaBMC = 10; 
thresholdBMC = 0.8;
maxiterBMC = 300; 
tol1BMC = 2*1e-3;   
tol2BMC = 1*1e-5;

%% ML
Wrr1_ML = Wrr1;
Wrr2_ML = Wrr2;
Wrr3_ML = Wrr3;
Wrr4_ML = Wrr4;
Wrr5_ML = Wrr5;
Wdd1_ML = Wdd1;
Wdd2_ML = Wdd2;
Wrr1_ML(logical(eye(size(Wrr1_ML)))) = 0;
Wrr2_ML(logical(eye(size(Wrr2_ML)))) = 0;
Wrr3_ML(logical(eye(size(Wrr3_ML)))) = 0;
Wrr4_ML(logical(eye(size(Wrr4_ML)))) = 0;
Wrr5_ML(logical(eye(size(Wrr5_ML)))) = 0;
Wdd1_ML(logical(eye(size(Wdd1_ML)))) = 0;
Wdd2_ML(logical(eye(size(Wdd2_ML)))) = 0;

AR(1) = {Wrr1_ML};
AR(2) = {Wrr2_ML};
AR(3) = {Wrr3_ML};
AR(4) = {Wrr4_ML};
AR(5) = {Wrr5_ML};
AD(1) = {Wdd1_ML};
AD(2) = {Wdd2_ML};
[SR, SD, F] = MultiViewPrediction(AR, AD, Wdr', 0.1, 0.1);

%% ML(MC) 
trIndexBMC = double(Wdr ~= 0);
[A_bmc, iter] = fBMC(alphaBMC, betaBMC, Wdr, trIndexBMC, tol1BMC, tol2BMC, maxiterBMC, 0, 1);
Wdr0 = A_bmc.*double(A_bmc > thresholdBMC);
[SR_MC, SD_MC, F_MC] = MultiViewPrediction(AR, AD, Wdr0', 0.1, 0.1);        

P = max(F,F_MC);
