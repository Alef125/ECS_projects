%% Find Starting Time of Experiment
Tstart=0;

%% Separate Signals to 700ms distinct parts
experimentDatas= zeros(55,180,700,64);
for i= 1:180
    experimentDatas(:,i,:,:)= Signal(:, (Tstart+(i-1)*168+1):(Tstart+(i-1)*168+700) ,:);
end

%% Making StimulusCode Discrete
I= zeros(55,180);
for i=1:180
    % 10 could be a number between 1 and 168:
    I(:,i) = EEG_StimulusCode(:,168*(i-1)+10);
end

%% Merge Same 15 Experiments as Smoothing
rowColumnSignal= zeros(55,12,700,64);
for j=1:55
    for i=1:180
        rowColumnSignal(j,I(j,i),:,:)= rowColumnSignal(j,I(j,i),:,:)+ experimentDatas(j,i,:,:) /15;
    end
end