%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Find Starting Time of Experiment (Shift)
Tstart=0;

%% Separate Signals to 700ms distinct parts
experimentDatas= zeros(55,180,175,64);
for i= 1:180
    experimentDatas(:,i,:,:)= Signal(:, (Tstart+(i-1)*42+1):(Tstart+(i-1)*42+175) ,:);
end

%% Making StimulusCode Discrete
I= zeros(55,180);
for i=1:180
    % 10 could be a number between 1 and 168:
    I(:,i) = EEG_StimulusCode(:,168*(i-1)+10);
end

%% Merge Same 15 Experiments as Smoothing
rowColumnSignal= zeros(55,12,175,64);
for j=1:55
    for i=1:180
        rowColumnSignal(j,I(j,i),:,:)= rowColumnSignal(j,I(j,i),:,:)+ experimentDatas(j,i,:,:) /15;
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Labeling
% (This Part of Code is Based on The "Telephone Caller" Introduced in one_
% _of MATLAB HWs and promoted with some of friends)
charLabels=zeros(55,12);
chart = {'A' 'B' 'C' 'D' 'E' 'F' ; 
         'G' 'H' 'I' 'J' 'K' 'L' ;
         'M' 'N' 'O' 'P' 'Q' 'R' ;
         'S' 'T' 'U' 'V' 'W' 'X' ;
         'Y' 'Z' '1' '2' '3' '4' ;
         '5' '6' '7' '8' '9' '_'};
for n=1:55
    for i=1:6
        for j=1:6
            if ( EEG_TargetChar(n) == chart{i,j} )
                charLabels(n, i+6 )=1;  %Becaus row numbers are 7 to 12
                charLabels(n, j )=1;
                break;
            end
        end
    end 
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Calculating all features (Part a and b of question are merged)
%Features Cataloge: 
%       Last number of every things here declare the feature.:
%  1 --> Mean, subband 1
%  2 --> Mean, subband 2
%  3 --> Mean, subband 3
%  4 --> Mean, subband 4

%  5 --> Var, subband 1
%  6 --> Var, subband 2
%  7 --> Var, subband 3
%  8 --> Var, subband 4

%  9 --> Min, subband 1
%  10--> Min, subband 2
%  11--> Min, subband 3
%  12--> Min, subband 4

%  13--> Max, subband 1
%  14--> Max, subband 2
%  15--> Max, subband 3
%  16--> Max, subband 4
%% Parameter Allucating 
Nf = 16; %Number of Features Each Part
feature1 =zeros(55*12,64*Nf);
feature2 =zeros(55*12,64*Nf);
%fftConstant=2*pi/700;
%fftSignal=zeros(55,12,175,64);
%derivation=zeros(55,12,174,64);

% Feature calculating: (All could be in 1 loop, but is like this because of
% being separated) 
%% 1. Average / Integral
for i=1:55
    for j=1:12
        for k=1:64
            %Wavelet
            [C,L]= wavedec( rowColumnSignal(i,j,:,k),3,'db1');
            feature1((i-1)*12+j,(k-1)*Nf+1)= sum( C(1 : L(1)) ) / L(1) ;
            feature1((i-1)*12+j,(k-1)*Nf+2)= sum( C(1+L(1) : L(1)+L(2)) ) / L(2) ;
            feature1((i-1)*12+j,(k-1)*Nf+3)= sum( C(1+L(1)+L(2) : L(1)+L(2)+L(3)) ) / L(3) ;
            feature1((i-1)*12+j,(k-1)*Nf+4)= sum( C(1+L(1)+L(2)+L(3) : L(1)+L(2)+L(3)+L(4)) ) / L(4) ;
            feature1((i-1)*12+j,(k-1)*Nf+5)= var( C(1 : L(1)) ) ;
            feature1((i-1)*12+j,(k-1)*Nf+6)= var( C(1+L(1) : L(1)+L(2)) );
            feature1((i-1)*12+j,(k-1)*Nf+7)= var( C(1+L(1)+L(2) : L(1)+L(2)+L(3)) );
            feature1((i-1)*12+j,(k-1)*Nf+8)= var( C(1+L(1)+L(2)+L(3) : L(1)+L(2)+L(3)+L(4)) );
            feature1((i-1)*12+j,(k-1)*Nf+9)= min( C(1 : L(1)) );
            feature1((i-1)*12+j,(k-1)*Nf+10)= min( C(1+L(1) : L(1)+L(2)) );
            feature1((i-1)*12+j,(k-1)*Nf+11)= min( C(1+L(1)+L(2) : L(1)+L(2)+L(3)) );
            feature1((i-1)*12+j,(k-1)*Nf+12)= min( C(1+L(1)+L(2)+L(3) : L(1)+L(2)+L(3)+L(4)) );
            feature1((i-1)*12+j,(k-1)*Nf+13)= max( C(1 : L(1)) ) / L(1) ;
            feature1((i-1)*12+j,(k-1)*Nf+14)= max( C(1+L(1) : L(1)+L(2)) );
            feature1((i-1)*12+j,(k-1)*Nf+15)= max( C(1+L(1)+L(2) : L(1)+L(2)+L(3)) );
            feature1((i-1)*12+j,(k-1)*Nf+16)= max( C(1+L(1)+L(2)+L(3) : L(1)+L(2)+L(3)+L(4)) );
            
            %STFT
            feature2((i-1)*12+j,(k-1)*Nf+1)= mean( abs( fft( rowColumnSignal(i,j,1:44,k) ) ));
            feature2((i-1)*12+j,(k-1)*Nf+2)= mean( abs( fft( rowColumnSignal(i,j,45:88,k) ) ));
            feature2((i-1)*12+j,(k-1)*Nf+3)= mean( abs( fft( rowColumnSignal(i,j,89:132,k) ) ));
            feature2((i-1)*12+j,(k-1)*Nf+4)= mean( abs( fft( rowColumnSignal(i,j,133:175,k) ) ));
            feature2((i-1)*12+j,(k-1)*Nf+5)= var( abs( fft( rowColumnSignal(i,j,1:44,k) ) ));
            feature2((i-1)*12+j,(k-1)*Nf+6)= var( abs( fft( rowColumnSignal(i,j,45:88,k) ) ));
            feature2((i-1)*12+j,(k-1)*Nf+7)= var( abs( fft( rowColumnSignal(i,j,89:132,k) ) ));
            feature2((i-1)*12+j,(k-1)*Nf+8)= var( abs( fft( rowColumnSignal(i,j,133:175,k) ) ));
            feature2((i-1)*12+j,(k-1)*Nf+9)= min( abs( fft( rowColumnSignal(i,j,1:44,k) ) ));
            feature2((i-1)*12+j,(k-1)*Nf+10)= min( abs( fft( rowColumnSignal(i,j,45:88,k) ) ));
            feature2((i-1)*12+j,(k-1)*Nf+11)= min( abs( fft( rowColumnSignal(i,j,89:132,k) ) ));
            feature2((i-1)*12+j,(k-1)*Nf+12)= min( abs( fft( rowColumnSignal(i,j,133:175,k) ) ));
            feature2((i-1)*12+j,(k-1)*Nf+13)= max( abs( fft( rowColumnSignal(i,j,1:44,k) ) ));
            feature2((i-1)*12+j,(k-1)*Nf+14)= max( abs( fft( rowColumnSignal(i,j,45:88,k) ) ));
            feature2((i-1)*12+j,(k-1)*Nf+15)= max( abs( fft( rowColumnSignal(i,j,89:132,k) ) ));
            feature2((i-1)*12+j,(k-1)*Nf+16)= max( abs( fft( rowColumnSignal(i,j,133:175,k) ) ));
        end
    end
end
feature1(:,:)=feature1(:,:)-ones(55*12,1)*mean(feature1(:,:));
%feature2(:,:)=feature2(:,:)-ones(55*12,1)*mean(feature2(:,:));

%% SVD
%1
[U1, S1, V1] = svd(feature1'*feature1);
SDiag1=diag(S1);
SDiagSum1=sum(SDiag1);
kSVD1=1;
addSVD1=SDiag1(1);
while(addSVD1 < 0.99 * SDiagSum1)
   kSVD1=kSVD1+1;
   addSVD1= addSVD1+SDiag1(kSVD1);
end

finalFeature1=feature1 * V1(:,1:kSVD);

%2
[U2, S2, V2] = svd(feature2'*feature2);
SDiag2=diag(S2);
SDiagSum2=sum(SDiag2);
kSVD2=1;
addSVD2=SDiag2(1);
while(addSVD2 < 0.99 * SDiagSum2)
   kSVD2=kSVD2+1;
   addSVD2= addSVD2+SDiag2(kSVD2);
end

finalFeature2=feature2 * V(:,1:kSVD2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Parameter Decleration 
Nfold = 20;
kFoldTry=1:660;
Error= zeros(1,Nfold);
allSvmLabels= zeros(660);

%% Random Inputs
%Wavelet
for i=1:Nfold
    kFoldTry= randperm(660);
    EEGFillWavelet;
    EEGLearningWavelet;
    Error = EEGError( allSvmLabels3 , allTrainingLabels);
    allSvmLabels = allSvmLabels + allSvmLabels3;
end
EEGResult;
display('Wavelet:');
Error
ErrorChar
resultChar
%STFT
for i=1:Nfold
    kFoldTry= randperm(660);
    EEGFillSTFT;
    EEGLearningWavelet;
    Error = EEGError( allSvmLabels3 , allTrainingLabels);
    allSvmLabels = allSvmLabels + allSvmLabels3;
end
EEGResult;
display('STFT:');
Error
ErrorChar
resultChar