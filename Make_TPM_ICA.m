clear all; close all;
cd  'C:\Users\canta\OneDrive - Monash University\'
for xx = 2:2
    if xx ==1
        ff = 'awake';
    elseif xx ==2
        ff = 'anest';
    end
    chann = 15; %number of components
    tp = 600; %time parameters
    trn = 2426; %data length
    trntp = tp*trn;
    c1n = 4; %criteria numbers
    c2n = 4; %criteria numbers
    %% Calculate TPM %%
    
    
    for i=5:chann-1
        load(['BinVals\ICA_binaryvalues_' num2str(i) '_' ff '.mat'])
        currChData = bv;
        for k=i+1:chann
            load(['BinVals\ICA_binaryvalues_' num2str(k) '_' ff '.mat'])
            pairChData = bv;
            
            %% SETUP BINARY MATRIX %%
            twochbinaries = strings(1,trntp);
            for hh = 1:trntp
                currChVal = currChData(hh);
                pairChVal = pairChData(hh);
                if currChVal == 0 && pairChVal == 0
                    twochbinaries(hh) = "00";
                elseif currChVal == 1 && pairChVal == 0
                    twochbinaries(hh) = "10";
                elseif currChVal == 0 && pairChVal == 1
                    twochbinaries(hh) = "01";
                elseif currChVal == 1 && pairChVal == 1
                    twochbinaries(hh) = "11";
                end
            end
            %% Calculate TPM Value %%
            TPM_final = zeros(c1n,c2n,trn);
            TPM_final_nodeconvpresum = zeros (c1n,2,trn);
            TPM_final_nodeconv = zeros (c1n,2,trn);
            
            for b = 1:c1n %loop for all combinations of binaries
                if b == 1
                    bintarget1 = "00";
                elseif b == 2
                    bintarget1 = "10";
                elseif b == 3
                    bintarget1 = "01";
                elseif b == 4
                    bintarget1 = "11";
                end
                
                for bb = 1:c2n
                    if bb == 1
                        bintarget2 = "00";
                    elseif bb == 2
                        bintarget2 = "10";
                    elseif bb == 3
                        bintarget2 = "01";
                    elseif bb == 4
                        bintarget2 = "11";
                    end
                    
                    TPM_Nx_mat_presum = zeros(1,trntp-1);
                    TPM_Nxy_presumdiv = zeros (1,trntp-1);
                    for hh = 1:trn
                        for s = 2:tp-1
                            intg = (hh-1)*tp+s;
                            % test for nx (total number of occurences of state)%
                            currBinString1 = twochbinaries(intg);
                            BinStringResult1 = strcmp(currBinString1, bintarget1); %tests whether matches first target
                            TPM_Nx_mat_presum(intg) = BinStringResult1;
                            
                            currBinString2 = twochbinaries(intg+1);
                            BinStringResult2 = strcmp(currBinString2, bintarget2); %test whether subsequent one matches second target
                            
                            if BinStringResult1 == 1 && BinStringResult2 == 1
                                compresult = 1;
                            else
                                compresult = 0;
                            end
                            TPM_Nxy_presumdiv(intg) = compresult;
                        end
                        
                        TPM_Nx_mat= sum (TPM_Nx_mat_presum(:)); %total sum of occurences
                        TPM_Nxy_mat = sum(TPM_Nxy_presumdiv(:)); %sum of causative occurences
                        TPM_final(b,bb,hh) = TPM_Nxy_mat/TPM_Nx_mat;
                        if isnan(TPM_final(b,bb,hh))
                            TPM_final(b,bb,hh) = 0;
                        end
                    end
                end
                
                
                %% now convert to nodes
                for n= 1:2
                    if n == 1
                        for h = 1:trn
                        TPM_final_nodeconvpresum(b,n,1,h) = TPM_final(b,2,h);
                        TPM_final_nodeconvpresum(b,n,2,h) = TPM_final(b,4,h);
                        TPM_final_nodeconv(b,n,h) = sum(TPM_final_nodeconvpresum(b,n,:,h));
                        end
                        
                    elseif n == 2
                        for h = 1:trn
                        TPM_final_nodeconvpresum(b,n,1,h) = TPM_final(b,3,h);
                        TPM_final_nodeconvpresum(b,n,2,h) = TPM_final(b,4,h);
                        TPM_final_nodeconv(b,n,h) = sum(TPM_final_nodeconvpresum(b,n,:,h));
                        end
                    end
                end
            end
            
            sprintf ('%d and %d component set is complete \n', i,k);
            save (['Lab_201920\Winter_Intern\TPM_Output\' num2str(i) '_' num2str(k) '_TPM_' ff '.mat'],'TPM_final_nodeconv')
            
        end
    end
    sprintf ('Condition %d is complete \n', xx);
end

