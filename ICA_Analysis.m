close all
clear all
%addpath('FastICA_25\')
channset = [54,55,56,142,151,160];
chann = length(channset);
cd  'C:\Users\canta\OneDrive - Monash University\'
for x = 2:2
    icaprodata = zeros(2426*600,172);
    if x == 1
        ff = 'awake';
    elseif x ==2
        ff = 'anest';
    end
    
%     load (['Lab_201920\rat1_' ff '.mat'])
%     
%     icapredata = data{1};
%     ntrials = length(icapredata(1,:,1));
%     
%     for time = 1:600
%         sprintf(['Starting time ' num2str(time)])
%         timeavg = mean(icapredata (:,:,time+50));
%         timeavg = mean(timeavg);
%         timestd = std(icapredata (:,:,time+50));
%         timestd= mean(timestd);
%         for chann = 1:172
%             for trials = 1:ntrials
%                 int = (time-1)*ntrials+trials;
%                 icaprodata(int,chann) = (icapredata(chann,trials,time+50) - timeavg) / timestd;
%             end
%         end
%     end
%     
%     save(['Lab_201920\Winter_Intern\icaprodata_' ff '.mat'], 'icaprodata')


   
load (['Lab_201920\Winter_Intern\icaprodata_' ff '.mat'])


    icapostdata = fastica(icaprodata','numOfIC', 15);
    icapostdata = icapostdata';
    
    save(['Lab_201920\Winter_Intern\icapostdata_' ff '.mat'], 'icapostdata')
    
    figure; scatterhist(icapostdata(:, 1), icapostdata(:, 2));
    figure;
    subplot(2, 1, 1); plot(icapostdata(:, 1));
    subplot(2, 1, 2); plot(icapostdata(:, 2));
    
    %% Scatter plot ICs
    % Rotate using view([angle 90]);
    
    figure; scatter(icapostdata(:, 1), icapostdata(:, 2));

end


