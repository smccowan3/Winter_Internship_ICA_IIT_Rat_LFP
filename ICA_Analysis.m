close all
clear all
%addpath('FastICA_25\')
cd  'C:\Users\canta\OneDrive - Monash University\'
for x = 1:1
    
    if x == 1
        ff = 'awake';
        fft = 'Awake';
    elseif x ==2
        ff = 'anest';
        fft = 'Anest';
    end
    
    load (['Lab_201920\rat1_' ff '.mat'])
    
    icapredata = data{1};
    trn = length(icapredata(1,:,1));
    icaprodata = zeros(trn*600,172);
    ntrials = length(icapredata(1,:,1));
    
    for time = 1:600
        sprintf(['Starting time ' num2str(time)])
        timeavg = mean(icapredata (:,:,time+50));
        timeavg = mean(timeavg);
        timestd = std(icapredata (:,:,time+50));
        timestd= mean(timestd);
        for chann = 1:172
            for trials = 1:ntrials
                int = (time-1)*ntrials+trials;
                icaprodata(int,chann) = (icapredata(chann,trials,time+50) - timeavg) / timestd;
            end
        end
    end
    
    save(['Lab_201920\Winter_Intern\icaprodata_' ff '.mat'], 'icaprodata')

end
%    
% load (['Lab_201920\Winter_Intern\icaprodata_' ff '.mat'])
% 
% 
%     [icapostdata, mixmat, sepmat] = fastica(icaprodata','numOfIC', 15);
%     icapostdata = icapostdata';
%     
%     save(['Lab_201920\Winter_Intern\icapostdata_' ff '.mat'], 'icapostdata', 'mixmat', 'sepmat')
%     
%     
%     
%     %% Plot IC Weights
%     mixmat = flipud(mixmat);
%     imagesc(mixmat);
%    
%     title(['Independant Component Weightings in ' fft])
%     colorbar;
% %    
% %     h= colorbar;
% %     set(h, 'ylim', [-1.5 1.5])
%     xlabel ('Independent Component')
%     xticks(1:1:length(icapostdata(1,:)));
%     yticks(1:11:172);
%     ylabels= 7:11:172;
%     ylabels = fliplr(ylabels);
%     set(gca,'YTickLabel',ylabels,'FontName','Times','fontsize',12)
%     ylabel ('Channel')
%    
%     saveas(gcf, ['Lab_201920\Winter_Intern\ICA_weightings_' ff '.png'])
% 
% 
% end


