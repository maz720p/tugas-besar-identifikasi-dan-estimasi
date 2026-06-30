%% ============================================================
%% MODEL 3: System Identification using dryer2 Dataset
%% Linear: State-Space (ssest) | Nonlinear: NLARX (Wavenet)
%% ============================================================

clc; clear; close all;

%% --- Step 1: Load and Inspect the Dataset ---
load dryer2;   % Loads variables 'u2' (input) and 'y2' (output)

% Create iddata object - dryer2 has Ts = 0.08s
Ts = 0.08;
z3 = iddata(y2, u2, Ts);
z3.InputName  = 'Heater Power';
z3.OutputName = 'Temperature';
z3.InputUnit  = 'W';
z3.OutputUnit = 'degC';

disp('=== Dataset Info ===');
disp(z3);

figure('Name','Model 3 - Raw Data');
plot(z3);
title('dryer2 - Hair Dryer Input/Output Data');
grid on;

%% --- Step 2: Preprocess - Remove Mean (Detrend) ---
z3d = detrend(z3);

figure('Name','Model 3 - Detrended Data');
plot(z3d);
title('dryer2 - Detrended Data');
grid on;

%% --- Step 3: Split Data ---
N = size(z3d.OutputData, 1);
nTrain = round(0.7 * N);
zTrain = z3d(1:nTrain);
zVal   = z3d(nTrain+1:end);

fprintf('Training samples: %d\n', size(zTrain.OutputData,1));
fprintf('Validation samples: %d\n', size(zVal.OutputData,1));

%% --- Step 4: Linear Identification - State-Space Model ---
% x(k+1) = A*x(k) + B*u(k) + K*e(k)
% y(k)   = C*x(k) + D*u(k) + e(k)
% We test state-space orders from 1 to 6

bestFit_ss = -inf;
bestOrder_ss = 0;
bestModel_ss = [];

fprintf('\n=== State-Space Order Selection ===\n');
for nx = 1:6
    try
        mdl = ssest(zTrain, nx);
        [~, fitPct] = compare(zVal, mdl);
        fprintf('SS (nx=%d) -> Validation Fit: %.2f%%\n', nx, fitPct);
        if fitPct > bestFit_ss
            bestFit_ss = fitPct;
            bestOrder_ss = nx;
            bestModel_ss = mdl;
        end
    catch ME
        fprintf('SS (nx=%d) failed: %s\n', nx, ME.message);
    end
end

fprintf('\nBest SS Order: nx=%d\n', bestOrder_ss);
fprintf('Best SS Validation Fit: %.2f%%\n', bestFit_ss);

disp('=== Best State-Space Model ===');
present(bestModel_ss);

% Pole-Zero Map
figure('Name','Model 3 - SS Pole-Zero Map');
pzmap(bestModel_ss);
title(sprintf('State-Space (nx=%d) - Pole-Zero Map', bestOrder_ss));
grid on;

% Step response
figure('Name','Model 3 - SS Step Response');
step(bestModel_ss);
title(sprintf('State-Space (nx=%d) - Step Response', bestOrder_ss));
grid on;

% Residual analysis
figure('Name','Model 3 - SS Residual Analysis');
resid(zVal, bestModel_ss);
title('SS Model - Residual Analysis');

%% --- Step 5: Nonlinear Identification - NLARX with Wavenet ---
% First, convert best SS to discrete for order extraction
% Use similar orders for NLARX regressors
na_nl = bestOrder_ss;
nb_nl = bestOrder_ss;
nk_nl = 1;

% Test NLARX with different wavenet unit counts
unitCounts = [5, 10, 15, 20];
bestFit_nlarx = -inf;
bestUnits = 0;
bestModel_nlarx = [];

fprintf('\n=== NLARX Wavenet Unit Count Selection ===\n');
for u = unitCounts
    try
        wn = wavenet('NumberOfUnits', u);
        mdl_nl = nlarx(zTrain, [na_nl nb_nl nk_nl], wn);
        [~, fitPct_nl] = compare(zVal, mdl_nl);
        fprintf('NLARX (wavenet, units=%d) -> Fit: %.2f%%\n', u, fitPct_nl);
        if fitPct_nl > bestFit_nlarx
            bestFit_nlarx = fitPct_nl;
            bestUnits = u;
            bestModel_nlarx = mdl_nl;
        end
    catch ME
        fprintf('NLARX (units=%d) failed: %s\n', u, ME.message);
    end
end

fprintf('\nBest NLARX Config: wavenet(%d units)\n', bestUnits);
fprintf('Best NLARX Validation Fit: %.2f%%\n', bestFit_nlarx);

%% --- Step 6: Compare Linear vs Nonlinear ---
figure('Name','Model 3 - Comparison');
compare(zVal, bestModel_ss, bestModel_nlarx);
legend('Measured', ...
       sprintf('SS (nx=%d) (%.1f%%)', bestOrder_ss, bestFit_ss), ...
       sprintf('NLARX-wavenet(%d) (%.1f%%)', bestUnits, bestFit_nlarx));
title('Linear (State-Space) vs Nonlinear (NLARX-Wavenet) - dryer2');
grid on;

% Prediction comparison
figure('Name','State Space Prediction');

predict(bestModel_ss, zVal, 1);

grid on

title('State Space - 1 Step Prediction')
grid on;
figure('Name','NLARX Prediction');

predict(bestModel_nlarx, zVal, 1);

grid on

title('NLARX - 1 Step Prediction')

%% --- Step 7: Summary Table ---
fprintf('\n========================================\n');
fprintf('  MODEL 3 SUMMARY (dryer2)\n');
fprintf('========================================\n');
fprintf('  Linear (SS nx=%d): %.2f%%\n', bestOrder_ss, bestFit_ss);
fprintf('  Nonlinear (NLARX wavenet %d): %.2f%%\n', bestUnits, bestFit_nlarx);
fprintf('  Improvement: %.2f%%\n', bestFit_nlarx - bestFit_ss);
fprintf('========================================\n');
