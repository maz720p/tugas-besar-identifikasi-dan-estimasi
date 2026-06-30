%% ============================================================
% STEP 1
% CREATE SYNTHETIC HAIR DRYER DATASET
% ============================================================

clc;
clear;
close all;

%% Sampling

Ts = 0.08;
N  = 1000;

t = (0:N-1)'*Ts;

%% ============================================================
% INPUT (PRBS)
%% ============================================================

rng(10)

u = idinput(N,'prbs');

u = 45 + 15*u;

%% ============================================================
% THERMAL MODEL
% Two thermal dynamics + dead time
%% ============================================================

delay = 3;

tau1 = 1.5;
tau2 = 5.0;

K1 = 1.0;
K2 = 0.9;

heater = zeros(N,1);
sensor = zeros(N,1);

for k = delay+2:N

    heater(k)=heater(k-1)+Ts/tau1*(-heater(k-1)+K1*u(k-delay));

    sensor(k)=sensor(k-1)+Ts/tau2*(-sensor(k-1)+K2*heater(k));

end

%% ============================================================
% Mild Nonlinearity
%% ============================================================

y = sensor;

y = y + 0.00025*(u-50).^2;

%% ============================================================
% Sensor Noise
%% ============================================================

rng(20)

y = y + 0.10*randn(N,1);

%% ============================================================
% Room Temperature Offset
%% ============================================================

y = y + 25;

%% ============================================================
% SAVE
%% ============================================================

scriptFolder=fileparts(mfilename('fullpath'));
projectFolder=fileparts(scriptFolder);

save(fullfile(projectFolder,'data','dryer2.mat'),...
    'u','y','Ts');

disp('Dataset berhasil dibuat.');

%% ============================================================
% PLOT
%% ============================================================

figure

subplot(2,1,1)

plot(t,u,'LineWidth',1.5)

grid on

xlabel('Time (s)')

ylabel('Power (W)')

title('Input Heater')

subplot(2,1,2)

plot(t,y,'LineWidth',1.5)

grid on

xlabel('Time (s)')

ylabel('Temperature (degC)')

title('Output Temperature')