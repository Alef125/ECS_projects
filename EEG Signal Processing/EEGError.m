function Error1 = EEGError( allSvmLabels , allTrainingLabels)
Error1=0;
        for i=1:660
             Error1 =Error1+ abs( allSvmLabels(i)-allTrainingLabels(i)  )/660 ;
        end
end
