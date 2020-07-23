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
    
    for time = 1:600
        sprintf(['Starting time ' num2str(time)])
        currdata = icapredata(:,:,time+50);
        currdata = currdata(:);
        timeavg (time)= mean(currdata);
        timestd(time)=  std(currdata);
        
        
    end
    plot(timeavg)
    title (['Avg Untransformed Timecourse ' ff])
    xlabel ('Time (ms)')
    ylabel ('LFP(mV)')
    saveas (gcf, ['avg_untransformed_timecourse_' ff '.png'])
    
    
    plot(timestd)
    title (['Std deviation Untransformed Timecourse ' ff])
    xlabel ('Time (ms)')
    ylabel ('LFP(mV)')
    saveas (gcf, ['stddev_untransformed_timecourse_' ff '.png'])
    
end

