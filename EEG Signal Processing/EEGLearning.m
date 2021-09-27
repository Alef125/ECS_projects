% SVM and 5-Fold Cross Validation Error
%% Paramater Declaration
%SVMStruct=
kf1=660/5; kf2=2*660/5; kf3=3*660/5; kf4=4*660/5;
svmLabels= zeros(660/5,5,Nf);
allSvmLabels2= zeros(660,Nf);
allSvmLabels3= zeros(660,Nf);

 %% SVM Learning
options.MaxIter = 1000000;
for j=1:Nf
    SVMStruct(1,j) = svmtrain(trainingData(:,:,1,j) , trainingLabel(:,1,1), 'Options', options);
    svmLabels(:,1,j) =  svmclassify(SVMStruct(1,j) , testData(:,:,1,j));

    SVMStruct(2,j) = svmtrain(trainingData(:,:,2,j) , trainingLabel(:,1,2), 'Options', options);
    svmLabels(:,2,j) =  svmclassify(SVMStruct(2,j) , testData(:,:,2,j));

    SVMStruct(3,j) = svmtrain(trainingData(:,:,3,j) , trainingLabel(:,1,3), 'Options', options);
    svmLabels(:,3,j) =  svmclassify(SVMStruct(3,j) , testData(:,:,3,j));

    SVMStruct(4,j) = svmtrain(trainingData(:,:,4,j) , trainingLabel(:,1,4), 'Options', options);
    svmLabels(:,4,j) =  svmclassify(SVMStruct(4,j) , testData(:,:,4,j));

    SVMStruct(5,j) = svmtrain(trainingData(:,:,5,j) , trainingLabel(:,1,5), 'Options', options);
    svmLabels(:,5,j) =  svmclassify(SVMStruct(5,j) , testData(:,:,5,j));
    
    allSvmLabels2(1:kf1,j)=svmLabels(:,1,j);
    allSvmLabels2(kf1+1:kf2,j)=svmLabels(:,2,j);
    allSvmLabels2(kf2+1:kf3,j)=svmLabels(:,3,j);
    allSvmLabels2(kf3+1:kf4,j)=svmLabels(:,4,j);
    allSvmLabels2(kf4+1:660,j)=svmLabels(:,5,j);
end


allSvmLabels3=allSvmLabels2;
