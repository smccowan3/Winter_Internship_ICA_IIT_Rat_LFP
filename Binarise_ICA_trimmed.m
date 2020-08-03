close all
cd  'D:\Lab_backup\Winter_Intern_D\'
load ('icapostdata_awakeanest_trimmed.mat')

%% split concatenated data
awakedata = icaconcdata(:,1:1455600);
save ('awake_icasplit_trimmed.mat', 'awakedata');
anestdata = icaconcdata(:,1456201:2911800);
save ('anest_icasplit_trimmed.mat', 'anestdata');

   

for xx = 1:2
    if xx == 1
        ff = 'awake';
        data = awakedata;
    else
        ff  = 'anest';
        data = anestdata;
    end
    chann = length(data(:,1));
    trn = length(data(1,:));
    %% BINARISATION %%
    volvals = data;
    for x =1:chann % length(volvals(:,))        
        sprintf('component %d has started', x);
        bv = zeros (1,trn-1);
        bv(1) = 1;
        for tr = 2:trn
            v = volvals(x,tr); %save ch, tr, t
            vpv = volvals(x,tr-1);
            if v > vpv
                bv(tr) = 1;
            elseif v <= vpv
                bv(tr) = 0;
            end
        end
            save (['BinVals_trimmed\ICA_binaryvalues_' num2str(x) '_' ff '.mat'], 'bv')
    end
end

