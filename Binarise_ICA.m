close all
clear all
cd  'C:\Users\canta\OneDrive - Monash University\Lab_201920\Winter_Intern\'
for xx = 1:2
    clearvars -except xx bv
    if xx ==1
        load icapostdata_awake.mat % /Users/Stuart/Documents/Monash2019/Lab_201920/rat1_awake.mat;
        ff = 'awake';
    elseif xx ==2
        load icapostdata_awake.mat
        ff = 'anest';
    end

    
    chann = length(icapostdata(1,:));
    trn = length(icapostdata(:,1));
    bv = zeros (trn,chann);
    %% BINARISATION %%
    volvals = icapostdata;
    for x =1:chann % length(volvals(:,))        
        sprintf('component %d has started', x);
        bv(1,x)= 1;
        for tr = 2:trn
            v = volvals(tr,x); %save ch, tr, t
            vpv = volvals(tr-1,x);
            if v > vpv
                bv(tr,x) = 1;
            elseif v <= vpv
                bv(tr,x) = 0;
            end
        end
    end
    save (['ICA_binaryvalues_' ff '.mat'], 'bv')
end


