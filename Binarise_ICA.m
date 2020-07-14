
cd  'C:\Users\canta\OneDrive - Monash University\Lab_201920'
for xx = 1:2
    clearvars -except xx bv
    if xx ==1
    load Lab_201920\rat1_awake.mat % /Users/Stuart/Documents/Monash2019/Lab_201920/rat1_awake.mat;
    ff = 'awake';
    elseif xx ==2
    load Lab_201920\rat1_anest.mat
    ff = 'anest';
    end

statp = 50; %start time
endtp = 650;
tp = endtp-statp;
for i = 1:172
channset(i) = i;
end
chann = length(channset);
repeatn = 19; %trial numbers- here we are doing repeats of the stimuli
stim = 126;
trn = stim*repeatn;

%% BINARISATION %%
volvals = cell2mat(data(1));
 %

for x =1:chann % length(volvals(:,))
    clearvars bv
    bv = zeros (trn,tp);
    ch = channset(x);
    hh = sprintf('Chann %d has started', ch);
    disp(hh)
    for tr = 1:trn %length(volvals, ch,:))
  % when time is at t in ms, if v(t) > v(t-1), bv is = 1      
        for t = 1:tp %time loop
        v = volvals(ch,tr,statp+t); %save ch, tr, t
        vpvn = statp+t-1;
        vpv = volvals(ch,tr,vpvn);
        if v > vpv
            bv(tr,t) = 1;
        elseif v <= vpv
            bv(tr,t) = 0;
        end
        end
    end
    reorgbv = zeros (126,19,tp);
     for freq = 1:18
        for int = 1:7
            sn = 7*(freq-1) + int;
            for h = 1:19 %trial (x axis)
            trinumb = data{1,2}{int,freq}(h);
            reorgbv (sn,h,:) = bv(trinumb,:);
            end
        end
     end
    save (['Lab_201920\BinVals\chann' num2str(ch) 'binaryvalues_' ff '.mat'], 'reorgbv')
end
 
end



