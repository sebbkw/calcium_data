
% load Fall.mat file into workspace
% load stimulus file into workspace (e.g. ***outDat_2021_3_12_13_43_29.mat)

clear dF
% convert raw fluorescence into deltaF/F
for i=1:size(F,1);
    dF(i,:)=calc_dF(F(i,1:32400)-(0.7*Fneu(i,1:32400)));
end;



%% 
% order data into stimulus-trials and omission-trials
% with the 1026 stimulus-trials at the front and the 54 omission-trials at
% the end.

Traces = dF(:,1:32400);

trials=size(outDat.trialOrder,1);
TrialsRaw=(reshape(Traces,size(Traces,1),30,trials));

[a,ind]=sort(outDat.trialOrder);
TrialsOrdered=TrialsRaw(:,:,ind);

%%
% plot average trace for stimulus-trials and omission-trials for all ROIs
% haven't applied any pre-selection. Can use the 'iscell' variable to
% restrict plotting to ROIs that Suite2P considers to be cells.

Nrois=size(TrialsOrdered,1);

figure
for i=1:Nrois,
    
    subtightplot(ceil(sqrt(Nrois)),ceil(sqrt(Nrois)),i)
    plot(squeeze(mean(TrialsOrdered(i,:,1:1026),3)))
    hold all
    plot(squeeze(mean(TrialsOrdered(i,:,1027:1080),3)))
    axis tight
    axis off
end


%%
% pick out one of the ROIs and plot some more things

Example=4;

% plot traces from all omission trials
figure
imagesc(squeeze(TrialsOrdered(Example,:,1027:1080))')

% plot traces with errorbars
figure,shadedErrorBar(1:30,mean(TrialsOrdered(Example,:,1027:1080),3),std(TrialsOrdered(Example,:,1027:1080),[],3)./sqrt(54),'lineProps','r')
hold on,shadedErrorBar(1:30,mean(TrialsOrdered(Example,:,1:1026),3),std(TrialsOrdered(Example,:,1:1026),[],3)./sqrt(1026),'lineProps','g')

ylabel('dF/F')

xlabel('time')





