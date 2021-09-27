%% Parameter Decleration 
Nfold = 10; %Number of Random making
kFoldTry=1:660;
ErrorB= zeros(1,Nfold);
allSvmLabelsB= zeros(660,1);
JB=zeros(1,64*Nf);
for i=1:Nf
    JB( (i-1)*64+1 : i*64 )=J(:,i);
end
Nbest=180;
trainingLabelB= trainingLabel;
trainingDataB= zeros( 660*4/5 , Nbest, 5);
testDataB= zeros (660/5, Nbest,5);
svmLabelsB= zeros(660/5,5);
allSvmLabels2B= zeros(660,1);
allSvmLabels3B= zeros(660,1);
newSvmLabelsB= zeros(55,12);
rowB= zeros(1,55);
columnB= zeros(1,55);
resultCharB(55)='t';

%% Random Inputs
    [sortVec , Imax]= sort( JB ); 
    xImax= fix( (Imax-1)/64 ) + 1;
    yImax= mod(Imax,64);  
for i=1:Nfold
    kFoldTry= randperm(660);
    % Filling training Labels 
    trainingLabelB(:,1,1)= allTrainingLabels( kFoldTry(kf1+1:660) );

    trainingLabelB(1:kf1,1,2)= allTrainingLabels( kFoldTry(1:kf1) );
    trainingLabelB(kf1+1:kf4,1,2)= allTrainingLabels( kFoldTry(kf2+1:660) );

    trainingLabelB(1:kf2,1,3)= allTrainingLabels( kFoldTry(1:kf2) );
    trainingLabelB(kf2+1:kf4,1,3)= allTrainingLabels( kFoldTry(kf3+1:660) );

    trainingLabelB(1:kf3,1,4)= allTrainingLabels( kFoldTry(1:kf3) );
    trainingLabelB(kf3+1:kf4,1,4)= allTrainingLabels( kFoldTry(kf4+1:660) );

    trainingLabelB(:,1,5)= allTrainingLabels( kFoldTry(1:kf4) );
    
    % Filling Training Datas
        for j=1:Nbest
            if (yImax(j)==0)
                  yImax(j)=64;
            end
            trainingDataB(:,j,1)= feature( kFoldTry(kf1+1:660),yImax(j),xImax(j));

            trainingDataB(1:kf1,j,2)= feature( kFoldTry(1:kf1) ,yImax(j),xImax(j));
            trainingDataB(kf1+1:kf4,j,2)= feature( kFoldTry(kf2+1:660),yImax(j),xImax(j) );

            trainingDataB(1:kf2,j,3)= feature( kFoldTry(1:kf2) ,yImax(j),xImax(j) );
            trainingDataB(kf2+1:kf4,j,3)= feature( kFoldTry(kf3+1:660) ,yImax(j),xImax(j) );

            trainingDataB(1:kf3,j,4)= feature( kFoldTry(1:kf3) ,yImax(j),xImax(j));
            trainingDataB(kf3+1:kf4,j,4)= feature( kFoldTry(kf4+1:660) ,yImax(j),xImax(j));

            trainingDataB(:,j,5)= feature( kFoldTry(1:kf4),yImax(j),xImax(j));
        end
    % Filling Test Datas
        for j=1:Nbest
            testDataB(:,j,1)= feature( kFoldTry(1:kf1) ,yImax(j),xImax(j));
            testDataB(:,j,2)= feature( kFoldTry(kf1+1:kf2) ,yImax(j),xImax(j));
            testDataB(:,j,3)= feature( kFoldTry(kf2+1:kf3) ,yImax(j),xImax(j));
            testDataB(:,j,4)= feature( kFoldTry(kf3+1:kf4) ,yImax(j),xImax(j));
            testDataB(:,j,5)= feature( kFoldTry(kf4+1:660) ,yImax(j),xImax(j));
        end
    options.MaxIter = 1000000;
    SVMStruct(1) = svmtrain(trainingDataB(:,:,1) , trainingLabelB(:,1,1), 'Options', options);
    svmLabelsB(:,1) =  svmclassify(SVMStruct(1) , testDataB(:,:,1));

    SVMStruct(2) = svmtrain(trainingDataB(:,:,2) , trainingLabelB(:,1,2), 'Options', options);
    svmLabelsB(:,2) =  svmclassify(SVMStruct(2) , testDataB(:,:,2));

    SVMStruct(3) = svmtrain(trainingDataB(:,:,3) , trainingLabelB(:,1,3), 'Options', options);
    svmLabelsB(:,3) =  svmclassify(SVMStruct(3) , testDataB(:,:,3));

    SVMStruct(4) = svmtrain(trainingDataB(:,:,4) , trainingLabelB(:,1,4), 'Options', options);
    svmLabelsB(:,4) =  svmclassify(SVMStruct(4) , testDataB(:,:,4));

    SVMStruct(5) = svmtrain(trainingDataB(:,:,5) , trainingLabelB(:,1,5), 'Options', options);
    svmLabelsB(:,5) =  svmclassify(SVMStruct(5) , testDataB(:,:,5));
    
    allSvmLabels2B(1:kf1)=svmLabelsB(:,1);
    allSvmLabels2B(kf1+1:kf2)=svmLabelsB(:,2);
    allSvmLabels2B(kf2+1:kf3)=svmLabelsB(:,3);
    allSvmLabels2B(kf3+1:kf4)=svmLabelsB(:,4);
    allSvmLabels2B(kf4+1:660)=svmLabelsB(:,5);
    for j=1:660
         allSvmLabels3B(kFoldTry(j))=allSvmLabels2B(j);
    end
    
    for j=1:660
             ErrorB(i) =ErrorB(i) + abs( allSvmLabels3B(j)-allTrainingLabels(j)  )/660 ;
    end
    
    allSvmLabelsB(:)=allSvmLabelsB(:)+allSvmLabels3B(:);
end
% Merging the result
        for i=1:55
            for k=1:12
                newSvmLabelsB(i, k) = newSvmLabelsB(i, k)+ allSvmLabelsB( 12*(i-1)+ k ) ;
            end
        end
        
        for i=1:55
            [~ , columnB(i)] =max( newSvmLabelsB(i,1:6) );
            [~ , rowB(i)] =max( newSvmLabelsB(i,7:12) );
            newSvmLabelsB(i,:,j)=zeros(1,12);
            newSvmLabelsB(i,rowB(i)+6)=1;
            newSvmLabelsB(i,columnB(i))=1;
        end
        %% Character Error
        ErrorCharB=0;
        for n =55:-1:1
                resultCharB(n)= chart{rowB(n),columnB(n)};
                if (resultCharB(n) ~= EEG_TargetChar(n))
                     ErrorCharB=ErrorCharB+1/55;
                end
        end