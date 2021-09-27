% SVM and 5-Fold Cross Validation Requiers Filling
%% Best Channels
Imax=zeros(64,Nf);
for i=1:Nf
    [sortVec , Imax(:,i)]= sort( J(:,i) ); 
end

%% Parameter Declaration
kf1=660/5; kf2=2*660/5; kf3=3*660/5; kf4=4*660/5;  
Nbest=40; % Number of Choosed channels
allTrainingLabels= zeros(660,1);
trainingLabel= zeros( 660*4/5, 1, 5);
trainingData= zeros( 660*4/5 , Nbest, 5, Nf);
testData= zeros (660/5, Nbest,5, Nf);

% 5-Fold Cross Validation:
%% Filling allTrainingLabels
for i=1:55
    for j=1:12
        allTrainingLabels((i-1)*12+j)= charLabels(i,j);
    end
end

%% Filling training Labels 
trainingLabel(:,1,1)= allTrainingLabels( kFoldTry(kf1+1:660) );

trainingLabel(1:kf1,1,2)= allTrainingLabels( kFoldTry(1:kf1) );
trainingLabel(kf1+1:kf4,1,2)= allTrainingLabels( kFoldTry(kf2+1:660) );

trainingLabel(1:kf2,1,3)= allTrainingLabels( kFoldTry(1:kf2) );
trainingLabel(kf2+1:kf4,1,3)= allTrainingLabels( kFoldTry(kf3+1:660) );

trainingLabel(1:kf3,1,4)= allTrainingLabels( kFoldTry(1:kf3) );
trainingLabel(kf3+1:kf4,1,4)= allTrainingLabels( kFoldTry(kf4+1:660) );

trainingLabel(:,1,5)= allTrainingLabels( kFoldTry(1:kf4) );

%% Filling Training Datas
for j=1:Nf
    for i=1:Nbest
        trainingData(:,i,1,j)= feature( kFoldTry(kf1+1:660),Imax(i,j),j);
        
        trainingData(1:kf1,i,2,j)= feature( kFoldTry(1:kf1) ,Imax(i,j),j);
        trainingData(kf1+1:kf4,i,2,j)= feature( kFoldTry(kf2+1:660),Imax(i,j),j);
        
        trainingData(1:kf2,i,3,j)= feature( kFoldTry(1:kf2) ,Imax(i,j),j);
        trainingData(kf2+1:kf4,i,3,j)= feature( kFoldTry(kf3+1:660) ,Imax(i,j),j);
       
        trainingData(1:kf3,i,4,j)= feature( kFoldTry(1:kf3) ,Imax(i,j),j);
        trainingData(kf3+1:kf4,i,4,j)= feature( kFoldTry(kf4+1:660) ,Imax(i,j),j);
        
        trainingData(:,i,5,j)= feature( kFoldTry(1:kf4),Imax(i,j),j);
    end
end

%% Filling Test Datas
for j=1:Nf
    for i=1:Nbest
        testData(:,i,1,j)= feature( kFoldTry(1:kf1) ,Imax(i,j),j);
        testData(:,i,2,j)= feature( kFoldTry(kf1+1:kf2) ,Imax(i,j),j);
        testData(:,i,3,j)= feature( kFoldTry(kf2+1:kf3) ,Imax(i,j),j);
        testData(:,i,4,j)= feature( kFoldTry(kf3+1:kf4) ,Imax(i,j),j);
        testData(:,i,5,j)= feature( kFoldTry(kf4+1:660) ,Imax(i,j),j);
    end
end


