% SVM and 5-Fold Cross Validation Error
%% Paramater Declaration
%SVMStruct=
kf1=660/5; kf2=2*660/5; kf3=3*660/5; kf4=4*660/5;
svmLabels= zeros(660/5,5);
allSvmLabels2= zeros(660);
allSvmLabels3= zeros(660);

 %% SVM Learning
    options.MaxIter = 1000000;
        SVMStruct(1) = svmtrain(trainingData(:,:,1) , trainingLabel(:,1,1), 'Options', options);
        svmLabels(:,1) =  svmclassify(SVMStruct(1) , testData(:,:,1));

        SVMStruct(2) = svmtrain(trainingData(:,:,2) , trainingLabel(:,1,2), 'Options', options);
        svmLabels(:,2) =  svmclassify(SVMStruct(2) , testData(:,:,2));

        SVMStruct(3) = svmtrain(trainingData(:,:,3) , trainingLabel(:,1,3), 'Options', options);
        svmLabels(:,3) =  svmclassify(SVMStruct(3) , testData(:,:,3));

        SVMStruct(4) = svmtrain(trainingData(:,:,4) , trainingLabel(:,1,4), 'Options', options);
        svmLabels(:,4) =  svmclassify(SVMStruct(4) , testData(:,:,4));

        SVMStruct(5) = svmtrain(trainingData(:,:,5) , trainingLabel(:,1,5), 'Options', options);
        svmLabels(:,5) =  svmclassify(SVMStruct(5) , testData(:,:,5));

        allSvmLabels2(1:kf1)=svmLabels(:,1);
        allSvmLabels2(kf1+1:kf2)=svmLabels(:,2);
        allSvmLabels2(kf2+1:kf3)=svmLabels(:,3);
        allSvmLabels2(kf3+1:kf4)=svmLabels(:,4);
        allSvmLabels2(kf4+1:660)=svmLabels(:,5);



allSvmLabels3=allSvmLabels2;
