close all
clear all

cd  'D:\Lab_backup\Winter_Intern_D\'

% 
% load ('rat1_awake.mat')
% awakedata = data{1};
% load('rat1_anest.mat')
% anestdata = data{1};
% icapredata = zeros(172,length(awakedata(1,:,1))+ length(anestdata(1,:,1)), 650);
% for chann = 1:172
%     for time = 1:650
%        icapredata(chann,1:2427,time)  = awakedata(chann, :,time);
%        icapredata(chann,2428:4853,time) = anestdata(chann,:,time);
%     end
% end
% 
% save('icapretrimdata.mat','icapredata','-v7.3')
% 
% %load('icapretrimdata.mat');
% 
% ntrials = length(icapredata(1,:,1));
% icaprodata = zeros(ntrials*600,172);
% 
% for time = 1:600
%     sprintf(['Starting time ' num2str(time)])
%     meandata = icapredata(:,:,time+50);
%     meandata = meandata(:);
%     meandatatrim = rmoutliers(meandata,'percentiles',[5 95]);
%     timeavg = mean(meandatatrim);
%     timestd= std(meandatatrim);
%     for chann = 1:172
%         for trials = 1:ntrials
%             int = (trials-1)*600+time;
%             icaprodata(int,chann) = (icapredata(chann,trials,time+50) - timeavg) / timestd;
%         end
%     end
% end
% 
% save('icaprodata_awakeanest_trimmed.mat', 'icaprodata','-v7.3')

load('icaprodata_awakeanest_trimmed.mat')

clearvars -except icaprodata %% save some memory
addpath('FastICA_25\')

%[icaconcdata, mixmat, sepmat] = fastica(icaprodata', 'numofIC', 15); %%fastica takes chan x samples
clearvars -except icaprodata
[~,~,~,explained_var] = pca(icaprodata'); %% pca takes samples x chann
save('pca_explainedvar_trimmed.mat','explained_var');
%save('icapostdata_awakeanest_trimmed.mat','icaconcdata', 'mixmat', 'sepmat') %'explained_var')






%
%
% %% avg trial
% preavgtrial = zeros(172,600);
% avtrial = zeros(600);
%     load (['rat1_' ff '.mat'])
%
%     icapredata = data{1};
% for time = 1:600
%     for chann = 1:172
%     preavgtrial (chann,time) = mean (icapredata
% graphdata1 = icapredata(c,tri,51:650);
% graphdata1 = squeeze(graphdata1);
% graphdata2 = icaprodata(601:1200,c)';
% plot(graphdata1)
% title (['Avg Untransformed Timecourse Channel ' num2str(c) ' Trial ' num2str(tri)])
% xlabel ('Time (ms)')
% ylabel ('Amplitude (mV)')
% saveas (gcf, ['avg_untransformed_timecourse_channel_' num2str(c) '_tr_' num2str(tri) '.png'])
% plot(graphdata2)
% title (['Avg Transformed Timecourse Channel ' num2str(c) ' Trial ' num2str(tri)])
% xlabel ('Time (ms)')
% ylabel ('Amplitude (mV)')
% saveas (gcf, ['avg_transformed_timecourse_channel_' num2str(c) '_tr_' num2str(tri) '.png'])
%
%
%
%
%
% % %% check data after std dev etc.
% %
% c = 1;
% tri = 2;
% graphdata1 = icapredata(c,tri,51:650);
% graphdata1 = squeeze(graphdata1);
% graphdata2 = icaprodata(601:1200,c)';
% plot(graphdata1)
% title (['Untransformed Timecourse Channel ' num2str(c) ' Trial ' num2str(tri)])
% xlabel ('Time (ms)')
% ylabel ('Amplitude (mV)')
% saveas (gcf, ['untransformed_timecourse_channel_' num2str(c) '_tr_' num2str(tri) '.png'])
% plot(graphdata2)
% title (['Transformed Timecourse Channel ' num2str(c) ' Trial ' num2str(tri)])
% xlabel ('Time (ms)')
% ylabel ('Amplitude (mV)')
% saveas (gcf, ['transformed_timecourse_channel_' num2str(c) '_tr_' num2str(tri) '.png'])
%
%



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


