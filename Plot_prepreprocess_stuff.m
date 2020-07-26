close all
clear all)
cd  'D:\Lab_backup\Winter_Intern_D\'
for x = 1:2
    
    if x == 1
        ff = 'awake';
        fft = 'Awake';
    elseif x ==2
        ff = 'anest';
        fft = 'Anest';
    end
    
    load (['rat1_' ff '.mat'])
    timeavg = zeros(1,600);
    
    timestd = zeros(1,600);
    icapredata = data{1};
    travg = zeros (length(icapredata(1,:,1)),600) ;
    
    for time = 1:600
        sprintf(['Starting time ' num2str(time)])
        for tr = 1:length(icapredata(1,:,1))
            %travg(tr,time) = mean(icapredata(:,tr,time+50));
            travg(tr,time) = icapredata(3,tr,time+50);
        end
        
        
        %         currdata = icapredata(:,:,time+50);
        %         currdata = currdata(:);
        %         timeavg (time)= mean(currdata);
        %         timestd(time)=  std(currdata);
        %
        
    end
    
    %     %% within trial zscoring
    %     for tr = 1:length(icapredata(1,:,1))
    %         pta = travg(tr,:);
    %         pta = pta(:);
    %         meantravg = mean(pta);
    %         stdtravg = std(pta);
    %         for time = 1:600
    %             travg(tr,time) = (travg(tr,time)-meantravg)/stdtravg;
    %         end
    %
    %     end
    %      for time = 1:600
    %         timeavg(time) = mean(travg(:,time));
    %     end
    %% betweeen trial zscoring
    for time = 1:600
        pta = travg(:,time);
        pta = pta(:);
        meantravg = mean(pta);
        stdtravg = std(pta);
        for tr = 1:length(icapredata(1,:,1))
            travg(tr,time) = (travg(tr,time)-meantravg)/stdtravg;
        end
        timeavg(time) = mean(travg(:,time));
    end
    
%     imagesc(travg)
%     title (['Timecourse Colorplot Channel 3 Z-score Transformed ' fft])
%     colorbar
%     xlabel ('Time (ms)')
%     %xticks([0:100:600])
%     ylabel ('Trial')
%     %yticks([1:500:length(icapredata(1,:,1))])
%     saveas (gcf, ['cplot_avg_untransformed_timecourse_chan3_timezscore' ff '.png'])
%     
    plot(timeavg)
    title (['Z-score transformed Timecourse Channel 3 ' fft])
    xlabel ('Time (ms)')
    ylabel ('Z-score')
    saveas (gcf, ['avg_z-score_transformed_timecourse_C3_giventime' ff '.png'])
    
    %
    %     plot(timestd)
    %     title (['Std deviation Untransformed Timecourse ' ff])
    %     xlabel ('Time (ms)')
    %     ylabel ('LFP(mV)')
    %     saveas (gcf, ['stddev_untransformed_timecourse_' ff '.png'])
    
end

