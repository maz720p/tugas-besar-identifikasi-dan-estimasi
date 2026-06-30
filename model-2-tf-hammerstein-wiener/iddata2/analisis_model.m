clc; clear; close all;

load iddata2
load bestTF
load HW

zvalid = iddata2(351:end);

%% BEST TF
figure;
compare(zvalid,bestTF);
title('Best Transfer Function');

%% BODE
figure;
bode(bestTF);
grid on;

%% POLE ZERO
figure;
pzmap(bestTF);
grid on;

%% TF vs HW
figure;
compare(zvalid,bestTF,HW);
title('TF vs HW');

%% RESIDUAL
figure;
resid(zvalid,bestTF);

%% NONLINEARITY
figure;
plot(HW.InputNonlinearity);

figure;
plot(HW.OutputNonlinearity);