clc;
clear;
close all;

N = 500;
Ts = 0.1;

%% input PRBS
u = idinput(N,'prbs');

%% membuat sistem simulasi manual
y = zeros(N,1);

for k = 4:N

    y(k) = ...
        1.8*y(k-1) ...
      - 1.1*y(k-2) ...
      + 0.25*y(k-3) ...
      + 0.4*u(k-1) ...
      + 0.2*u(k-2);

end

%% noise
y = y + 0.05*randn(N,1);

%% iddata
iddata2 = iddata(y,u,Ts);

save iddata2 iddata2

figure;
plot(y);
grid on;
title('Output Dataset');

fprintf('Dataset berhasil dibuat\n');
fprintf('min = %f\n',min(y));
fprintf('max = %f\n',max(y));