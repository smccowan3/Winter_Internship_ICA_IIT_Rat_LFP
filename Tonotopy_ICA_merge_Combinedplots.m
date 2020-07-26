cd  'D:\Lab_backup\Winter_Intern_D\'
components = 15;%changethis
repeatn = 19;
int = 7;
freq = 18;
time = 600;
%f= colormap(jet(18));
%q = colormap(jet(8));
for i = 1%:components %:components-1
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
        
        %         %% PLOT FREQ
        %         clr = [f(fr,1),f(fr,2),f(fr,3)];
        %         plot(freqmeantrial(fr,:), 'MarkerFaceColor', clr)
        %
        %         hold on
    end
    %     title (['IC ' num2str(i) ' All Freqs Average Trial Time Course'])
    %     xlabel ('Time (ms)')
    %     ylabel ('Amplitude (mV)')
    %     saveas(gcf, ['Tonotopic_Analysis\IC_' num2str(i) '_All_Frequencies_timecourse.png'])
    %     close all
    %
    %% plot clr plot
    imagesc(flipud(freqmeantrial))
    title (['IC ' num2str(i) ' All Freqs Average Trial Time Course Colorplot'])
    xticks(0:100:600)
    yticks(1:1:18)
    colorbar;
    xlabel ('Time (ms)')
    ylabel ('Stimulus Frequency (Hz)')
    
    prefreqlabels =  {[1.6, 2, 2.5, 3.2, 4, 5, 6.4, 8, 10, 13, 16, 20, 25, 32, 40, 50, 57, 64]};
    for hg = 1:length(prefreqlabels{:})
        freqlabels{hg}=num2str(prefreqlabels{1}(hg));
    end
    freqlabelsinv = fliplr(freqlabels);
    yticklabels(freqlabelsinv)
    
    saveas(gcf, ['Tonotopic_Analysis\IC_' num2str(i) '_Cplot_All_Frequencies_timecourse.png'])
    
    
    
    close all
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
        %         clr = [q(in,1),q(in,2),q(in,3)];
        %         plot(intmeantrial(in,:),'MarkerFaceColor', clr)
        %         hold on
    end
    %
    %     title (['IC ' num2str(i) ' All Intensities Average Trial Time Course'])
    %     xlabel ('Time (ms)')
    %     ylabel ('LFP (mV)')
    %     saveas(gcf, ['Tonotopic_Analysis\IC_' num2str(i) '_All_Intensities_timecourse.png'])
    
    %% plot clr plot
    imagesc(flipud(intmeantrial))
    title (['IC ' num2str(i) ' All Intensities Average Trial Time Course Colorplot'])
    xticks(0:100:600)
    yticks(1:1:8)
    colorbar;
    xlabel ('Time (ms)')
    ylabel ('Stimulus Intensity (dB)')
    
    intlabelsinv ={'80','70','60','50','40','30','20'};
    %intlabelsinv = fliplr(intlabels);
    yticklabels(intlabelsinv)
    
    saveas(gcf, ['Tonotopic_Analysis\IC_' num2str(i) '_Cplot_All_Intensities_timecourse.png'])
    
    
    
end


