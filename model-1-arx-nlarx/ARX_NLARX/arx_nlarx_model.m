%% ============================================================
%% MODEL 1: System Identification using iddata1 (z1)
%% Linear: ARX Model | Nonlinear: NLARX Model
%% ============================================================

clc; clear; close all;

%% --- Step 1: Load and Inspect the Dataset ---
load iddata1;   % Loads variable 'z1' (SISO iddata object)
disp('=== Dataset Info ===');
disp(z1);

% Visualize raw data
figure('Name','Model 1 - Raw Data');
plot(z1);
title('iddata1 (z1) - Input/Output Data');
grid on;

%% --- Step 2: Split Data into Training and Validation ---
N = size(z1.OutputData, 1);     % Total number of samples
nTrain = round(0.7 * N);       % 70% for training
zTrain = z1(1:nTrain);         % Training data
zVal   = z1(nTrain+1:end);     % Validation data

fprintf('Training samples: %d\n', size(zTrain.OutputData,1));
fprintf('Validation samples: %d\n', size(zVal.OutputData,1));

%% --- Step 3: Linear Identification - ARX Model ---
% ARX structure: A(q)y(t) = B(q)u(t-nk) + e(t)
% We test multiple orders [na nb nk]

orders = [2 2 1; 3 3 1; 4 4 1; 2 3 1; 3 2 1; 4 3 1];
bestFit_arx = -inf;
bestOrder_arx = [];
bestModel_arx = [];

fprintf('\n=== ARX Model Order Selection ===\n');
for i = 1:size(orders,1)
    na = orders(i,1); nb = orders(i,2); nk = orders(i,3);
    mdl = arx(zTrain, [na nb nk]);
    [~, fitPct] = compare(zVal, mdl);
    fprintf('ARX[%d,%d,%d] -> Validation Fit: %.2f%%\n', na, nb, nk, fitPct);
    if fitPct > bestFit_arx
        bestFit_arx = fitPct;
        bestOrder_arx = [na nb nk];
        bestModel_arx = mdl;
    end
end

fprintf('\nBest ARX Order: [%d, %d, %d]\n', bestOrder_arx);
fprintf('Best ARX Validation Fit: %.2f%%\n', bestFit_arx);

% Display the best ARX model
disp('=== Best ARX Model ===');
present(bestModel_arx);

% Residual analysis for the best ARX model
figure('Name','Model 1 - ARX Residual Analysis');
resid(zVal, bestModel_arx);
title('ARX Model - Residual Analysis');

%% --- Step 4: Nonlinear Identification - NLARX Model ---
% NLARX: y(t) = f(y(t-1),...,y(t-na), u(t-nk),...,u(t-nk-nb+1)) + e(t)
% Uses the best ARX orders as regressor structure

% Define nonlinearity estimators to compare
nonlinEstimators = {wavenet, sigmoidnet, treepartition};
nonlinNames = {'Wavenet', 'Sigmoidnet', 'Treepartition'};

bestFit_nlarx = -inf;
bestNL = '';
bestModel_nlarx = [];

fprintf('\n=== NLARX Nonlinearity Comparison ===\n');
for i = 1:length(nonlinEstimators)
    try
        mdl_nl = nlarx(zTrain, [bestOrder_arx(1) bestOrder_arx(2) bestOrder_arx(3)], ...
                        nonlinEstimators{i});
        [~, fitPct_nl] = compare(zVal, mdl_nl);
        fprintf('NLARX (%s) -> Validation Fit: %.2f%%\n', nonlinNames{i}, fitPct_nl);
        if fitPct_nl > bestFit_nlarx
            bestFit_nlarx = fitPct_nl;
            bestNL = nonlinNames{i};
            bestModel_nlarx = mdl_nl;
        end
    catch ME
        fprintf('NLARX (%s) failed: %s\n', nonlinNames{i}, ME.message);
    end
end

fprintf('\nBest NLARX Nonlinearity: %s\n', bestNL);
fprintf('Best NLARX Validation Fit: %.2f%%\n', bestFit_nlarx);

%% --- Step 5: Compare Linear vs Nonlinear ---
figure('Name','Model 1 - Comparison');
compare(zVal, bestModel_arx, bestModel_nlarx);
legend('Measured', ...
       sprintf('ARX [%d,%d,%d] (%.1f%%)', bestOrder_arx, bestFit_arx), ...
       sprintf('NLARX-%s (%.1f%%)', bestNL, bestFit_nlarx));
title('Linear (ARX) vs Nonlinear (NLARX) - iddata1');
grid on;

%% --- Step 6: Summary Table ---
fprintf('\n========================================\n');
fprintf('  MODEL 1 SUMMARY (iddata1)\n');
fprintf('========================================\n');
fprintf('  Linear  (ARX [%d,%d,%d]):  %.2f%%\n', bestOrder_arx, bestFit_arx);
fprintf('  Nonlinear (NLARX-%s): %.2f%%\n', bestNL, bestFit_nlarx);
fprintf('  Improvement: %.2f%%\n', bestFit_nlarx - bestFit_arx);
fprintf('========================================\n');
