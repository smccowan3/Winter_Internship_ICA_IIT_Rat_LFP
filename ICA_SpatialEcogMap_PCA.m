close all
cd  'D:\Lab_backup\Winter_Intern_D\'
components = 15;%changethis
ecogmap = cell(1,172);
rows = 1:19;
columns = 1:10;
evenrows = [2,4,6,8,10,12,14,16,18];
oddrows = [1,3,5,7,9,11,13,15,17,19];
rowstart = [1,165,8,172,17,171,26,170,35,169,44,168,53,167,62,166,71,157,80];



for x = 1:19 %1:length(rowstart)
    chann = (rowstart(x));
    
    %% define the length of each row on the array
    if chann >= 87 && x >=4 && x <=16
        maxpoints = 10;
        gain = [0,-8,-17,-26,-35,-44,-53,-62,-71,-79];
        modif = 0;
    elseif chann >= 87 && x ==2 || x==18
        maxpoints = 8;
        gain = [0,-9,-18,-27,-36,-45,-54,-63];
        modif = 1;
    elseif chann <= 86 && x >=3 && x <=17
        maxpoints = 9;
        gain = [0,1,2,3,4,5,6,7,8];
        modif = .5;
    elseif chann <= 86 && x ==1 || x == 19
        maxpoints = 7;
        gain = [0,1,2,3,4,5,6];
        modif = 1.5;
    end
    
    
    % where the array starts on the right
    startpoint = maxpoints;
    
    for h = 1: maxpoints
        currgain = gain(h);
        currchann = chann+currgain;
        res  = h-1;
        
        ecogmap {currchann} = [20-x,startpoint-res+modif];
    end
end
load ('pca_explainedvar_trimmed.mat')
mixmat = abs(coeff);
for IC = 1:15 %components
    if IC < 10
        ind = ['0' num2str(IC)];
    else
        ind = num2str(IC);
    end
    currICw = mixmat(:,IC);
    for cn = 1:length(ecogmap)
        currcn = ecogmap{1,cn};
        label = num2str(cn);
        clr = currICw(cn);
        subplot(3,5,IC);
        scatter(currcn(2), currcn(1), 90, clr, 'filled')
        %text(currcn(2)+.2, currcn(1), label, 'fontsize', 6)
        xlim ([0 11])
        ylim ([0 20])
        colorbar ;
        %h= colorbar;
        %set(h, 'ylim', [-1 1])
        hold on
    end
    hold on
    title(['PC ' ind])
    set(gca,'Color','black')
    %figure('Renderer', 'painters', 'Position', [10 10 900 600])

    hold on
end
    %saveas(gcf, ['ICA_Weighting_Maps_trimmed\IC_Weightings_Awakeanest.png'])



