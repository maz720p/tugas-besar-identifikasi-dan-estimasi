clc; clear;

load iddata2

y = iddata2.OutputData;

figure;
plot(y,'LineWidth',1.5);
grid on;
title('Test Output');

fprintf('min y = %f\n',min(y));
fprintf('max y = %f\n',max(y));
fprintf('mean y = %f\n',mean(y));