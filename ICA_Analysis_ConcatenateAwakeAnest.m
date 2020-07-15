close all
clear all
%addpath('FastICA_25\')
cd  'C:\Users\canta\OneDrive - Monash University\'
for x = 1:2
    icaprodata = zeros(2426*600+2427*600,172);
    if x == 1
        ff = 'awake';
        load(['Lab_201920\Winter_Intern\icaprodata_' ff '.mat'])
        data_awake = icaprodata;
        
    elseif x ==2
        ff = 'anest';
         load(['Lab_201920\Winter_Intern\icaprodata_' ff '.mat'])
        data_anest = icaprodata;
        
    end
end


icapreconcdata = vertcat(data_awake, data_anest);

clearvars  -except icapreconcdata
[icaconcdata, mixmat, sepmat] = fastica(icapreconcdata','numOfIC', 15);
icaconcdata = icaconcdata';
save('Lab_201920\Winter_Intern\icapostdata_awakeanest.mat', 'icaconcdata', 'mixmat', 'sepmat')



%% Plot IC Weights
mixmat = flipud(mixmat);
imagesc(mixmat);

title('Independent Component Weightings in Awake/Anest')
colorbar;

    h= colorbar;
    set(h, 'ylim', [-1 1])
xlabel ('Independent Component')
xticks(1:1:length(icaconcdata(1,:)));
yticks(1:11:172);
ylabels= 7:11:172;
ylabels = fliplr(ylabels);
set(gca,'YTickLabel',ylabels,'FontName','Times','fontsize',12)
ylabel ('Channel')

saveas(gcf,'Lab_201920\Winter_Intern\ICA_weightings_Awake_and_Anest.png')



