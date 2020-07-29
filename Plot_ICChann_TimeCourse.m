close all
clear all)
cd  'D:\Lab_backup\Winter_Intern_D\'

%% PRE ICA
load ('icaprodata_awakeanest_trimmed.mat')

awakedata = icaprodata(1:1456200,:);
anestdata = icaprodata(1456201:2911800,:);
for x = 1:2
    if x == 1
        data = awakedata;
        ff = 'Awake';
    elseif x ==2
        data = anestdata;
        ff = 'Anest';
    end
meantimecourse = zeros(172,600);
for ch = 1:172
    currdata = data(:,ch);
    datamat = zeros(length(data(:,1))/600,600);
for trials = 1:length(data(:,1))/600
    intg = (trials-1)*600;
    for time = 1:600
        datamat(trials,time)= currdata(intg+time);
    end
end

for time = 1:600
    meantimecourse(ch,time) = mean(datamat(:,time));
end
end
% now plot
climtest = meantimecourse(:);
CLIM =  prctile (climtest, [5 95]);
%imagesc(meantimecourse, [CLIM])
imagesc(meantimecourse, [-.25 .25])
title (['Z-scored Avg Timecourse Across Trials All Channs ' ff])
colorbar
xlabel ('Time (ms)')
ylabel ('Channel')
saveas (gcf, ['Sanity_Checks\cplot_avg_transformed_trimmed_allchanns_' ff '.png'])
end
clear all
close all
%% POST ICA
load ('icapostdata_awakeanest_trimmed.mat')
awakedata = icaconcdata(:,1:1456200);
anestdata = icaconcdata(:,1456201:2911800);
for x = 2
    if x == 1
        data = awakedata;
        ff = 'Awake';
    elseif x ==2
        data = anestdata;
        ff = 'Anest';
    end
meantimecourse = zeros(15,600);
for comp = 1:15 %components
    currdata = data(comp,:);
    datamat = zeros(length(data(1,:))/600,600);
for trials = 1:length(data(1,:))/600
    intg = (trials-1)*600;
    for time = 1:600
        datamat(trials,time)= currdata(intg+time);
    end
end

for time = 1:600
    meantimecourse(comp,time) = mean(datamat(:,time));
end
end
% now plot
climtest = meantimecourse(:);
CLIM =  prctile (climtest, [5 95]);
imagesc(meantimecourse, [CLIM])
title (['All ICs Avg Timecourse Across Trials ' ff])
colorbar
xlabel ('Time (ms)')
ylabel ('Independent Component')
yticks([1:1:15])
saveas (gcf, ['Sanity_Checks\cplot_avg_transformed_ICs_trimmed_ ' ff '.png'])
end

