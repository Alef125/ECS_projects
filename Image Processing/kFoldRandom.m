%% Parameter Decleration 
Nfold = 10;
kFoldTry=1:660;
Error= zeros(1,Nf,Nfold);
allSvmLabels= zeros(660,Nf);

%% Random Inputs
for i=1:Nfold
    kFoldTry= randperm(660);
    EEGFill;
    EEGLearning;
    Error = EEGError( allSvmLabels3 , allTrainingLabels(:) , Nf );
    allSvmLabels(:,:)=allSvmLabels(:,:)+allSvmLabels3(:,:);
end
EEGResult;