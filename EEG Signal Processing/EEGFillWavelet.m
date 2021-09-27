% SVM and 5-Fold Cross Validation Requiers Filling
%% Parameter Declaration
kf1=660/5; kf2=2*660/5; kf3=3*660/5; kf4=4*660/5;  
Nbest=kSVD1; % Number of Choosed channels
allTrainingLabels= zeros(660);
trainingLabel= zeros( 660*4/5, 1, 5);
trainingData= zeros( 660*4/5 , 5, Nbest);
testData= zeros (660/5, 5, Nbest);

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
for i=1:Nbest
        trainingData(:,1,i)= feature1( kFoldTry(kf1+1:660),i);
        
        trainingData(1:kf1,2,i)= feature1( kFoldTry(1:kf1) ,i);
        trainingData(kf1+1:kf4,2,i)= feature1( kFoldTry(kf2+1:660),i);
        
        trainingData(1:kf2,3,i)= feature1( kFoldTry(1:kf2) ,i);
        trainingData(kf2+1:kf4,3,i)= feature1( kFoldTry(kf3+1:660) ,i);
       
        trainingData(1:kf3,4,i)= feature1( kFoldTry(1:kf3) ,i);
        trainingData(kf3+1:kf4,4,i)= feature1( kFoldTry(kf4+1:660) ,i);
        
        trainingData(:,5,i)= feature1( kFoldTry(1:kf4),i);
end

%% Filling Test Datas
for i=1:Nbest
        testData(:,1,i)= feature1( kFoldTry(1:kf1) ,i);
        testData(:,2,i)= feature1( kFoldTry(kf1+1:kf2) ,i);
        testData(:,3,i)= feature1( kFoldTry(kf2+1:kf3) ,i);
        testData(:,4,i)= feature1( kFoldTry(kf3+1:kf4) ,i);
        testData(:,5,i)= feature1( kFoldTry(kf4+1:660) ,i);
end


