%% ICA SANITY CHECKS %%
clear all
close all
cd  'D:\Lab_backup\Winter_Intern_D\'
load ('rat1_awake.mat')

% channel to check
chann= 2;
travg = zeros(18,7);
datamean = zeros(1,19);

%%% Find best intensity/freq Graph %%
indexes = data{2};
samples = data{1};


% for freq = 1:18
%     for int = 1:7
%         for tr = 1:19
%             currtrial = indexes{int,freq}(tr);
%             currdata = zeros(1,600);
%             for time = 1:600
%             currdata(time) = samples(chann,currtrial, time+50);
%             end
%             datamean(tr) = mean(currdata);
%         end
%         travg(freq,int) = mean(datamean);
%     end
% end
%
% freqavg = zeros(1,18);
% for freq= 1:18
%     freqavg (freq)= mean(travg(freq,:));
% end
%
% intavg = zeros (1,7);
% for int = 1:7
%     intavg (int) = mean(travg(:,int));
% end

%%% now best ones %%

topfre = 10;
topint = 3;
botfre = 6;
botint = 4;

%% top plots FREQ
close all
topplot = zeros (1,600);
currdata = zeros(1,600);
intsmean = zeros(7,600);
intsstd = zeros(7,600);
topplotstd = zeros(1,600);

for int = 1:7
    trs = zeros(19,600);
    for tr = 1:19
        currtrial = indexes{int,topfre}(tr);
            for time = 1:600
            trs(tr,time) = samples(chann,currtrial, time+50);
            end
    end
    
    for time = 1:600
    intsmean(int,time) = mean(trs(:,time));
    intsstd(int,time) = std(trs(:,time));
    end
end

for time = 1:600
topplot(time) = mean(intsmean(:,time));
topplotstd(time) = mean (intsstd(:,time))/sqrt(7*19);
end
prefreqlabels =  [1.6, 2, 2.5, 3.2, 4, 5, 6.4, 8, 10, 13, 16, 20, 25, 32, 40, 50, 57, 64];
currfreq = num2str(prefreqlabels(topfre));
plot(topplot, 'MarkerFaceColor', 'red', 'LineWidth', 6)
hold on
errorbar(topplot,topplotstd, 'LineWidth', .25, 'MarkerFaceColor', 'black')
title(['Best Frequency ' currfreq ' kHz Channel ' num2str(chann) ' in Awake'])
xlabel('Time(ms)')
ylabel('LFP(mV)')
saveas(gcf,'Sanity_Checks/Channel2TopFreq.png')

close all

%%% worstfreq

topplot = zeros (1,600);
currdata = zeros(1,600);
intsmean = zeros(7,600);
intsstd = zeros(7,600);
topplotstd = zeros(1,600);

for int = 1:7
    trs = zeros(19,600);
    for tr = 1:19
        currtrial = indexes{int,botfre}(tr);
            for time = 1:600
            trs(tr,time) = samples(chann,currtrial, time+50);
            end
    end
    
    for time = 1:600
    intsmean(int,time) = mean(trs(:,time));
    intsstd(int,time) = std(trs(:,time));
    end
end

for time = 1:600
topplot(time) = mean(intsmean(:,time));
topplotstd(time) = mean (intsstd(:,time))/sqrt(7*19);
end
prefreqlabels =  [1.6, 2, 2.5, 3.2, 4, 5, 6.4, 8, 10, 13, 16, 20, 25, 32, 40, 50, 57, 64];
currfreq = num2str(prefreqlabels(botfre));
plot(topplot, 'MarkerFaceColor', 'red', 'LineWidth', 6)
hold on
errorbar(topplot,topplotstd, 'LineWidth', .25, 'MarkerFaceColor', 'black')
title(['Worst Frequency ' currfreq ' kHz Channel ' num2str(chann) ' in Awake'])
xlabel('Time(ms)')
ylabel('LFP(mV)')
saveas(gcf,'Sanity_Checks/Channel2TBotFreq.png')






