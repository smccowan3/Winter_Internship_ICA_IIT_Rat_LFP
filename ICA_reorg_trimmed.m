clear all
close all
cd  'D:\Lab_backup\Winter_Intern_D\'
components = 15;%changethis
repeatn = 19;
int = 7;
freq = 18;
load ('icapostdata_awakeanest_trimmed.mat')

awakedata = icaconcdata(:,1:1456200);
anestdata = icaconcdata(:,1456201:2911800);

for xx = 1:2
    if xx == 1
        fft = 'awake';
        ff = 'awake';
    elseif xx == 2
        fft = 'Anest';
        ff = 'anest';
    end
    if xx ==1
        icaconcdata = awakedata;
    elseif xx == 2
        icacondata = anestdata;
    end
    
    load (['rat1_' ff '.mat'])
    index = data{2};
    
    for i = 1:components
        reorg_ica = zeros(18,7,19,600);
        for tr = 1:repeatn
            for in = 1:int
                for fr =1:freq
                    currtrial = index{in,fr}(tr);
                    for s = 1:600
                        thistrial = currtrial+s-1;
                        reorg_ica(fr,in,tr,s) = icaconcdata(i,thistrial);
                    end
                end
            end
        end
        
        save(['ICA_Output_reorg_trimmed\' ff 'reorg_ICA_' num2str(i) '.mat'], 'reorg_ica')
        
    end
end



