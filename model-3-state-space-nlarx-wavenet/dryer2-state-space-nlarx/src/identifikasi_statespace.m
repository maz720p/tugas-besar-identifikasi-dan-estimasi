%% ============================================================
% STEP 3
% LINEAR SYSTEM IDENTIFICATION
% STATE-SPACE MODEL (SSEST)
%
% Author : Fauzan Randy Susanto
% Project : Hair Dryer System Identification
%% ============================================================

clc;
clear;
close all;

%% ============================================================
% Menentukan Folder Project
%% ============================================================

scriptFolder  = fileparts(mfilename('fullpath'));
projectFolder = fileparts(scriptFolder);

dataFolder    = fullfile(projectFolder,'data');
modelFolder   = fullfile(projectFolder,'models');
resultFolder  = fullfile(projectFolder,'results','figures');

%% ============================================================
% Load Data Hasil Preprocessing
%% ============================================================

load(fullfile(dataFolder,'dryer2_preprocessed.mat'));

disp('==========================================');
disp(' STATE-SPACE IDENTIFICATION ');
disp('==========================================');

%% ============================================================
% Order Selection
%% ============================================================

bestFit   = -Inf;
bestOrder = 0;
bestModel = [];

fitTable = zeros(6,2);

fprintf('\nSearching Best State-Space Order...\n\n');

for nx = 1:6

    fprintf('----------------------------------\n');
    fprintf('Estimating State Order = %d\n',nx);

    try

        opt = ssestOptions;
        opt.Focus = 'prediction';

        model = ssest(zTrain,nx,opt);

        [~,fit,~] = compare(zVal,model);

        fit = fit(1);

        fprintf('Validation Fit = %.2f %%\n',fit);

        fitTable(nx,:) = [nx fit];

        if fit > bestFit

            bestFit   = fit;
            bestOrder = nx;
            bestModel = model;

        end

    catch ME

        fprintf('FAILED : %s\n',ME.message);

    end

end

%% ============================================================
% Result
%% ============================================================

fprintf('\n========================================\n');
fprintf(' BEST STATE SPACE MODEL\n');
fprintf('========================================\n');

fprintf('Best Order          : %d\n',bestOrder);
fprintf('Validation Fit      : %.2f %%\n',bestFit);

%% ============================================================
% Save Model
%% ============================================================

save(fullfile(modelFolder,'bestSS.mat'),...
    'bestModel',...
    'bestOrder',...
    'bestFit');

disp(' ');
disp('Best model saved to models/bestSS.mat');

%% ============================================================
% Display Model
%% ============================================================

disp(' ');
disp('========================================');
disp('MODEL INFORMATION');
disp('========================================');

present(bestModel)

%% ============================================================
% State Space Matrices
%% ============================================================

[A,B,C,D,K,X0] = ssdata(bestModel);

disp(' ');
disp('========================================');
disp('STATE SPACE MATRICES');
disp('========================================');

disp('Matrix A');
disp(A);

disp('Matrix B');
disp(B);

disp('Matrix C');
disp(C);

disp('Matrix D');
disp(D);

disp('Kalman Gain K');
disp(K);

disp('Initial State X0');
disp(X0);

%% ============================================================
% Eigenvalues
%% ============================================================

disp(' ');
disp('========================================');
disp('EIGENVALUES');
disp('========================================');

eigA = eig(A);

disp(eigA);

%% ============================================================
% Fit Table
%% ============================================================

disp(' ');
disp('========================================');
disp('ORDER COMPARISON');
disp('========================================');

disp(array2table(fitTable,...
    'VariableNames',{'Order','ValidationFit'}));

%% ============================================================
% Pole Zero Map
%% ============================================================

figure('Name','Pole Zero Map');

pzmap(bestModel);

grid on

title(sprintf('State Space Pole Zero Map (Order %d)',bestOrder));

%% ============================================================
% Step Response
%% ============================================================

figure('Name','Step Response');

step(bestModel);

grid on

title(sprintf('Step Response (Order %d)',bestOrder));

%% ============================================================
% Compare Validation Data
%% ============================================================

figure('Name','Validation');

compare(zVal,bestModel);

grid on

title(sprintf('Validation Result (Fit = %.2f%%)',bestFit));

%% ============================================================
% Residual Analysis
%% ============================================================

figure('Name','Residual Analysis');

resid(zVal,bestModel);

%% ============================================================
% Simulation Comparison
%% ============================================================

figure('Name','Simulation');

compare(zTrain,bestModel);

grid on

title('Training Data Simulation');

%% ============================================================
% Save Figures
%% ============================================================

try

    exportgraphics(findobj('Name','Pole Zero Map'),...
        fullfile(resultFolder,'pzmap.png'),'Resolution',300);

catch
end

try

    exportgraphics(findobj('Name','Step Response'),...
        fullfile(resultFolder,'step_response.png'),'Resolution',300);

catch
end

try

    exportgraphics(findobj('Name','Validation'),...
        fullfile(resultFolder,'validation_ss.png'),'Resolution',300);

catch
end

disp(' ');
disp('========================================');
disp('STATE SPACE IDENTIFICATION FINISHED');
disp('========================================');