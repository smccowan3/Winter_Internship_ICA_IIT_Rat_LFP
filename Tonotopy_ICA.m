cd  'D:\Lab_backup\Winter_Intern_D\'
components = 15;%changethis
repeatn = 19;
int = 7;
freq = 18;
time = 600;

load(['ICA_Output_reorg\' ff 'reorg_ICA_' num2str(i) '.mat'])
awakedata = 

for xx = 1:2
    if xx == 1
        fft = 'awake';
        ff = 'awake';
    elseif xx == 2
        fft = 'Anest';
        ff = 'anest';
    end
    
    for i = 1:components %:components-1
        
        
        %% FOR FREQUENCY
        freqpre = zeros(freq,time, int);
        freqmeantrial = zeros(freq,time);
        
        for fr = 1: freq
            for s = 1: time
                for in = 1:int
                    freqpre (fr,s,in) = mean(reorg_ica(fr,in,:,s));
                end
                freqmeantrial(fr,s) = mean(freqpre(fr,s,:));
            end
        
        %% PLOT FREQ
        plot(freqmeantrial(fr,:))
        title (['IC ' num2str(i) ' Frequency ' num2str(fr) ' Average Trial Time Course'])
        xlabel ('Time (ms)')
        ylabel ('Amplitude (mV)')
        saveas(gcf, ['Tonotopic_Analysis\IC_' num2str(i) '_Frequency_' num2str(fr) '_timecourse.png'])
        end
        
        %% FOR INTENSITY
        intpre = zeros(int,time,freq);
        intmeantrial = zeros(int,time);
        for in = 1: int
            for s = 1: time
                for fr = 1:freq
                    intpre (in,s,fr) = mean(reorg_ica(fr,in,:,s));
                end
                intmeantrial(in,s) = mean(intpre(in,s,:));
            end
        
        %% PLOT INT
        plot(intmeantrial(in,:))
        title (['IC ' num2str(i) ' Intensity ' num2str(in) ' Average Trial Time Course'])
        xlabel ('Time (ms)')
        ylabel ('Amplitude (mV)')
        saveas(gcf, ['Tonotopic_Analysis\IC_' num2str(i) '_Intensity_' num2str(in) '_timecourse.png'])
        end
      
    end
end



