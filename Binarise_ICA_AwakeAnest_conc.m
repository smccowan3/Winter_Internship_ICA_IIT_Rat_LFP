close all
cd  'C:\Users\canta\OneDrive - Monash University\Lab_201920\Winter_Intern\'
load ('icapostdata_awakeanest.mat')

%% split concatenated data
awakedata = icaconcdata(1:1455600,:);
awakedata = awakedata';
anestdata = icaconcdata(1456201:2911800,:);
anestdata = anestdata';


for xx = 1:2
    if xx ==1
        ff = 'awake';
        icadata = awakedata;
    elseif xx == 2
        ff = 'anest';
        icadata = anestdata;
    end

    
    chann = length(icadata(:,1));
    trn = length(icadata(1,:));
    %% BINARISATION %%
    for x =1:chann % length(volvals(:,))  
        bv = zeros (1,trn);
        volvals = icadata(x,:);
        sprintf('component %d has started', x)
        bv(1)= 0;
        for tr = 2:trn
            v = volvals(tr); %save ch, tr, t
            vpv = volvals(tr-1);
            if v > vpv
                bv(tr) = 1;
            elseif v <= vpv
                bv(tr) = 0;
            end
        end
    save (['BinVals\ICA_binaryvalues_' num2str(x) '_' ff '.mat'], 'bv')
    end
end


