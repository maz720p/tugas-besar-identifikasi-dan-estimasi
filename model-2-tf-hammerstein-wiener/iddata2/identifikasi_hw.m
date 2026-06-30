clc; clear; close all;

load iddata2
load bestTF

ztrain = iddata2(1:350);
zvalid = iddata2(351:end);

HW = nlhw(...
    ztrain,...
    [bestNP bestNZ 1],...
    pwlinear,...
    pwlinear);

[~,fitHW,~] = compare(zvalid,HW);

fprintf('\nHAMMERSTEIN-WIENER FIT = %.2f %%\n',...
    fitHW);

save HW HW fitHW