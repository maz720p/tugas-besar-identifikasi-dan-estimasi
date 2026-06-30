%% ============================================================
% STEP 2
% DATA PREPROCESSING
% Hair Dryer Dataset
% Author : Fauzan Randy Susanto
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
resultFolder  = fullfile(projectFolder,'results','figures');

%% ============================================================
% Membuat folder jika belum ada
%% ============================================================

if ~exist(resultFolder,'dir')
    mkdir(resultFolder);
end

%% ============================================================
% Load Dataset
%% ============================================================

load(fullfile(dataFolder,'dryer2.mat'));

disp('=========================================')
disp('        HAIR DRYER DATASET')
disp('=========================================')

%% ============================================================
% Membuat iddata
%% ============================================================

z = iddata(y,u,Ts);

z.Name = 'Hair Dryer Dataset';

z.InputName = {'Heater Power'};
z.OutputName = {'Outlet Temperature'};

z.InputUnit = {'W'};
z.OutputUnit = {'degC'};

disp(z)

%% ============================================================
% Informasi Dataset
%% ============================================================

fprintf('\n');
fprintf('Jumlah Sampel      : %d\n',length(y));
fprintf('Sampling Time (Ts) : %.3f s\n',Ts);
fprintf('Durasi Data        : %.2f s\n',length(y)*Ts);

%% ============================================================
% Plot Raw Dataset
%% ============================================================

fig1 = figure('Name','Raw Dataset');

plot(z)

grid on

title('Hair Dryer Dataset (Raw)')

drawnow

try
    exportgraphics(fig1,...
        fullfile(resultFolder,'raw_data.png'),...
        'Resolution',300);
catch
    warning('Gagal menyimpan raw_data.png');
end

%% ============================================================
% Detrending
%% ============================================================

disp(' ')
disp('Menghilangkan nilai rata-rata (Detrend)...')

zDetrend = detrend(z);

%% ============================================================
% Plot Detrended Dataset
%% ============================================================

fig2 = figure('Name','Detrended Dataset');

plot(zDetrend)

grid on

title('Hair Dryer Dataset (Detrended)')

drawnow

try
    exportgraphics(fig2,...
        fullfile(resultFolder,'detrended_data.png'),...
        'Resolution',300);
catch
    warning('Gagal menyimpan detrended_data.png');
end

%% ============================================================
% Statistik Setelah Detrend
%% ============================================================

fprintf('\n');
fprintf('Mean Input  : %.6f\n',mean(zDetrend.InputData));
fprintf('Mean Output : %.6f\n',mean(zDetrend.OutputData));

%% ============================================================
% Split Training dan Validation
%% ============================================================

N = length(zDetrend.OutputData);

Ntrain = round(0.70*N);

zTrain = zDetrend(1:Ntrain);

zVal = zDetrend(Ntrain+1:end);

fprintf('\n');
fprintf('=====================================\n');
fprintf('DATA SPLITTING\n');
fprintf('=====================================\n');
fprintf('Total Data        : %d\n',N);
fprintf('Training Data     : %d\n',length(zTrain.OutputData));
fprintf('Validation Data   : %d\n',length(zVal.OutputData));

%% ============================================================
% Plot Training vs Validation
%% ============================================================

fig3 = figure('Name','Training Validation');

subplot(2,1,1)

plot(zTrain.OutputData,'b')

grid on

title('Training Output')

xlabel('Sample')

ylabel('Temperature')

subplot(2,1,2)

plot(zVal.OutputData,'r')

grid on

title('Validation Output')

xlabel('Sample')

ylabel('Temperature')

drawnow

try
    exportgraphics(fig3,...
        fullfile(resultFolder,'training_validation.png'),...
        'Resolution',300);
catch
    warning('Gagal menyimpan training_validation.png');
end

%% ============================================================
% Simpan Data Preprocessing
%% ============================================================

save(fullfile(dataFolder,'dryer2_preprocessed.mat'),...
    'z',...
    'zDetrend',...
    'zTrain',...
    'zVal',...
    'Ts');

disp(' ')
disp('=========================================')
disp('PREPROCESSING BERHASIL')
disp('=========================================')
disp('File yang dibuat:')
disp('1. dryer2_preprocessed.mat')
disp('2. raw_data.png')
disp('3. detrended_data.png')
disp('4. training_validation.png')
disp(' ')
disp('Silakan lanjut menjalankan:')
disp('src/identifikasi_statespace.m')