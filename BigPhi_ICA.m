close all
cd  'C:\Users\canta\OneDrive - Monash University\Lab_201920\Winter_Intern\'
components = 15;%changethis
load ('Phi_Ouptut\awake_phi_ICA_1_2.mat') %load to set parameters
states = length(state_phis(:,1));
trn = length(state_phis(1,:));
allchannplot = zeros(components,,19,2);
for xx = 1:2
    if xx == 1
        ff = 'Awake';
    elseif xx == 2
        ff = 'Anest';
    end
    for time = 1:3
        clearvars start
        start = zeros(1,chann-1);
        for i = 1:chann-1
            if i >=2
                start(1,i)=chann+1-i;
            end
            for k = i+1:chann

                l= sum(start(1,:)) +k -i;
                filename = ['\Phi_Output\' ff '\' num2str(time) '\Rat1' ff '_phi_channset_' num2str(i) '_' num2str(k) '.mat'];
                load ([filepath filename])
                for stim = 1:126
                    for tr = 1:19
                        allchannplot(l,stim,tr,time,xx) = mean(state_phis(:,tr,stim));
                    end
                end
            end
        end
    end
end

