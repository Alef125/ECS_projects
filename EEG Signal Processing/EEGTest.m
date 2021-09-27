%% Find Starting Time of Experiment
Tstart=0;

%% Separate Signals to 700ms distinct parts
experimentDatasTest= zeros(30,180,700,64);
for i= 1:180
    experimentDatasTest(:,i,:,:)= EEG_test_signal_FF(:, (Tstart+(i-1)*168+1):(Tstart+(i-1)*168+700) ,:);
end

%% Making StimulusCode Discrete
ITest= zeros(30,180);
for i=1:180
    % 10 could be a number between 1 and 168:
    ITest(:,i) = EEG_test_StimulusCode(:,168*(i-1)+10);
end

%% Merge Same 15 Experiments as Smoothing
rowColumnSignalTest= zeros(30,12,700,64);
for j=1:30
    for i=1:180
        rowColumnSignalTest(j,I(j,i),:,:)= rowColumnSignalTest(j,I(j,i),:,:)+ experimentDatasTest(j,i,:,:) /15;
    end
end

%% Features
featuresTest;






% SVM and 5-Fold Cross Validation Error
%% Paramater Declaration
%SVMStruct=
svmLabelsTest= zeros(30*12,Nf);
allSvmLabels3Test= zeros(30*12,Nf);

%% Best Channels
ImaxTest=zeros(64,Nf);
for i=1:Nf
    [sortVec , ImaxTest(:,i)]= sort( J(:,i) ); 
end

%% Training
trainingDataTest= zeros(660 , Nbest, Nf);
testDataTest=zeros(30*12,Nbest,Nf);
for j=1:Nf
    for i=1:Nbest
        trainingDataTest(:,i,j)= feature( kFoldTry,ImaxTest(i,j),j);
        testDataTest(:,i,j)= featureTest(:,Imax(i,j),j) ;
    end
end

 %% SVM Learning
options.MaxIter = 1000000;

    for j=1:Nf
        SVMStructTest(j) = svmtrain(trainingDataTest(:,:,j) , allTrainingLabels, 'Options', options);
        % testData(:,i,1,j)= feature( kFoldTry(1:kf1) ,Imax(i,j),j);
        svmLabelsTest(:,j) =  svmclassify( SVMStructTest(j) , testDataTest(:,:,j) );
    end
allSvmLabels3Test=svmLabelsTest;
% function resultChar =EEGResult( allSvmLabels, Nf )
    newSvmLabelsTest= zeros(30,12,Nf);
    sortIndexTest=zeros(30,12);
    rowTest= zeros(1,30,Nf);
    columnTest= zeros(1,30,Nf);
    resultCharTest(30,Nf)='t';
    % Merging the result 
    for j=1:Nf
        for i=1:30
            for k=1:12
                newSvmLabelsTest(i, k, j) = newSvmLabelsTest(i, k, j)+ allSvmLabels3Test( 12*(i-1)+ k ,j ) ;
            end
        end
    end
    % Defining the Rows and Colomns for Characters
    for j=1:Nf
        for i=1:30
            [~ , columnTest(i,j)] =max( newSvmLabels(i,1:6,j) );
            [~ , rowTest(i,j)] =max( newSvmLabels(i,7:12,j) );
            newSvmLabelsTest(i,:,j)=zeros(1,12);
            newSvmLabelsTest(i,rowTest(i)+6,j)=1;
            newSvmLabelsTest(i,columnTest(i),j)=1;
        end 
    end
    % Findin Characters
    chart = {'A' 'B' 'C' 'D' 'E' 'F' ; 
             'G' 'H' 'I' 'J' 'K' 'L' ;
             'M' 'N' 'O' 'P' 'Q' 'R' ;
             'S' 'T' 'U' 'V' 'W' 'X' ;
             'Y' 'Z' '1' '2' '3' '4' ;
             '5' '6' '7' '8' '9' '_'};
    for j=1:Nf
        for n =30:-1:1
                resultCharTest(n,j)= chart{rowTest(n,j),columnTest(n,j)};
        end
    end
%end
