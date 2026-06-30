clc; clear; close all;

load iddata2

%% Split data
ztrain = iddata2(1:350);
zvalid = iddata2(351:end);

fprintf('TRAIN = %d\n',length(ztrain.y));
fprintf('VALID = %d\n',length(zvalid.y));

bestFit = -inf;

for np = 1:3
    for nz = 0:2

        try
            sys = tfest(ztrain,np,nz);

            [~,fit,~] = compare(zvalid,sys);

            fprintf('TF(%d,%d) = %.2f %%\n',...
                np,nz,fit);

            if fit>bestFit
                bestFit = fit;
                bestTF = sys;
                bestNP = np;
                bestNZ = nz;
            end

        catch
        end
    end
end

fprintf('\n===== TF TERBAIK =====\n');
fprintf('np = %d\n',bestNP);
fprintf('nz = %d\n',bestNZ);
fprintf('fit = %.2f %%\n',bestFit);

save bestTF bestTF bestFit bestNP bestNZ