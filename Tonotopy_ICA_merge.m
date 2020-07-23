cd  'D:\Lab_backup\Winter_Intern_D\'
components = 15;%changethis
repeatn = 19;
int = 7;
freq = 18;
time = 600;

for i = 1:components %:components-1
load(['ICA_Output_reorg\awakereorg_ICA_' num2str(i) '.mat'])
awakedata = reorg_ica;
load(['ICA_Output_reorg\anestreorg_ICA_' num2str(i) '.mat'])
anestdata = reorg_ica;

    %% FOR FREQUENCY
    freqprepre = zeros(freq,time,int,repeatn*2);
    freqpre = zeros(freq,time, int);
    freqmeantrial = zeros(freq,time);
    
    for fr = 1: freq
        for s = 1: time
            for in = 1:int
                for tr = 1:repeatn
                    freqprepre (fr,s,in,tr) = awakedata(fr,in,tr,s);
                    freqprepre(fr,s,in,tr+19) = anestdata(fr,in,tr,s);
                end
                freqpre (fr,s,in) = mean(freqprepre(fr,s,in,:));
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
    intprepre = zeros(int,time,freq,repeatn*2);
    intmeantrial = zeros(int,time);
    for in = 1: int
        for s = 1: time
            for fr = 1:freq
                for tr = 1:repeatn
                    intprepre (in,s,fr,tr) = awakedata(fr,in,tr,s);
                    intprepre(in,s,fr,tr+19) = anestdata(fr,in,tr,s);
                end
                intpre (in,s,fr) = mean(intprepre(in,s,fr,:));
            end
            
            intmeantrial(in,s) = mean(intpre(in,s,:));
        end
        
        %% PLOT INT
        plot(intmeantrial(in,:))
        title (['IC ' num2str(i) ' Intensity ' num2str(in) ' Average Trial Time Course'])
        xlabel ('Time (ms)')
        ylabel ('LFP (mV)')
        saveas(gcf, ['Tonotopic_Analysis\IC_' num2str(i) '_Intensity_' num2str(in) '_timecourse.png'])
    end
    
end



