% Statistics Project
%% Parameter Declaration
lambda= 2.1;
miu= 1/2.1;
sigma= 0.1* miu;
N1= 40*1000;  % Number of numbers generated for finding alpha, part a
N2= 40*1000; % 1000 test to check alpha=0.05, part a
za= 1.960; % Z_0.025
ta= 2.023; %t_39,0.025

%% Generating random numbers
R1= rand(40,1000);
R2= rand(40,1000);
NED1= (-1/lambda)*log(R1);
NED2= (-1/lambda)*log(R2);

subplot (2,1,1);
histogram(R1(1,:),15);
subplot (2,1,2);
histogram(NED1(1,:),15);
pause(2);

NORM1= miu+ sigma*randn(40,1000);
NORM2= miu+ sigma*randn(40,1000);

subplot (1,1,1);
histogram(NORM1(1,:),15);
pause(2);

%% Make Test Statistics
%Negetive Exponantial
NEDXbar1=mean(NED1);
NEDXvar1=var(NED1) *(40/39); %sigma^2
histogram(NEDXbar1,50);
pause(2);

NEDXbar2=mean(NED2);
NEDXvar2=var(NED2)*(40/39); %s^2

%Normal
NORMXbar1=mean(NORM1);
NORMXvar1=var(NORM1) *(40/39); %sigma^2
histogram(NORMXbar1,50);
pause(2);

NORMXbar2=mean(NORM2);
NORMXvar2=var(NORM2)*(40/39); %s^2

%% Defining Alpha Limits
sortNED1=sort(NEDXbar1,2);
sortNORM1=sort(NORMXbar1,2);

NEDalphaLim1=(sortNED1(25)+sortNED1(26))/2;
NEDalphaLim2=(sortNED1(975)+sortNED1(976))/2;
NORMalphaLim1=(sortNORM1(25)+sortNORM1(26))/2;
NORMalphaLim2=(sortNORM1(975)+sortNORM1(976))/2;

%% Test Hypothesis
k=0;
for i=1:1000
    if (NEDXbar2(i)>NEDalphaLim1 && NEDXbar2(i)<NEDalphaLim2)
        k=k+1;
    end
end
alphaNED=k/10;
k=0;
for i=1:1000
    if (NORMXbar2(i)>NORMalphaLim1 && NORMXbar2(i)<NORMalphaLim2)
        k=k+1;
    end
end
alphaNORM=k/10;

%% Type 2 Error Defining
k=0;
for i=1:1000
    if (NEDXbar2(i)+0.2*miu  >NEDalphaLim1 && NEDXbar2(i)+0.2*miu <NEDalphaLim2)
        k=k+1;
    end
end
betaNED=k/10;
k=0;
for i=1:1000
    if (NORMXbar2(i)+0.2*miu>NORMalphaLim1 && NORMXbar2(i)+0.2*miu<NORMalphaLim2)
        k=k+1;
    end
end
betaNORM=k/10;

%% Another approach , Type 1 Error
zNED=(NEDXbar2-miu)/ sqrt( mean(NEDXvar1) / 40);
zNORM=(NORMXbar2-miu)/ sqrt( mean(NORMXvar1) /40 );
tNED=(NEDXbar2-miu)./( sqrt( NEDXvar2/40 ) );
tNORM=(NORMXbar2-miu)./( sqrt( NORMXvar2/40 ) );
% NED, NORMAL
k=0;
for i=1:1000
    if (abs(zNED(i))<za)
        k=k+1;
    end
end
alphaZNEDaccurancy=k/10;
% NED, t-student
 k=0;
for i=1:1000
    if (abs(tNED(i))<ta)
        k=k+1;
    end
end
alphaTNEDaccurancy=k/10;
% NORMAL, NORMAL
 k=0;
for i=1:1000
    if (abs(zNORM(i))<za)
        k=k+1;
    end
end
alphaZNORMaccurancy=k/10;
% NORMAL, t-student
 k=0;
for i=1:1000
    if (abs(tNORM(i)<ta))
        k=k+1;
    end
end
alphaTNORMaccurancy=k/10;

%% Another approach , Type 2 Error
zNED=(NEDXbar2+0.2*miu-miu)/ sqrt( mean(NEDXvar1) / 40);
zNORM=(NORMXbar2+0.2*miu-miu)/ sqrt( mean(NORMXvar1) /40 );
tNED=(NEDXbar2+0.2*miu-miu)./( sqrt( NEDXvar2/40 ) );
tNORM=(NORMXbar2+0.2*miu-miu)./( sqrt( NORMXvar2/40 ) );
% NED, NORMAL
k=0;
for i=1:1000
    if (abs(zNED(i))<za)
        k=k+1;
    end
end
betaZNEDaccurancy=k/10;
% NED, t-student
 k=0;
for i=1:1000
    if (abs(tNED(i))<ta)
        k=k+1;
    end
end
betaTNEDaccurancy=k/10;
% NORMAL, NORMAL
 k=0;
for i=1:1000
    if (abs(zNORM(i))<za)
        k=k+1;
    end
end
betaZNORMaccurancy=k/10;
% NORMAL, t-student
 k=0;
for i=1:1000
    if (abs(tNORM(i))<ta)
        k=k+1;
    end
end
betaTNORMaccurancy=k/10;

%% 10 numbers
R1ten= rand(10,1000);
R2ten= rand(10,1000);
NED1ten= (-1/lambda)*log(R1);
NED2ten= (-1/lambda)*log(R2);

subplot (2,1,1);
histogram(R1ten(1,:),15);
subplot (2,1,2);
histogram(NED1ten(1,:),15);
pause(2);

NORM1ten= miu+ sigma*randn(10,1000);
NORM2ten= miu+ sigma*randn(10,1000);

subplot (1,1,1);
histogram(NORM1ten(1,:),15);
pause(2);

NEDXbar1ten=mean(NED1ten);
NEDXvar1ten=var(NED1ten) *(10/9); %sigma^2
histogram(NEDXbar1ten,50);
pause(2);

NEDXbar2ten=mean(NED2ten);
NEDXvar2ten=var(NED2ten)*(10/9); %s^2

NORMXbar1ten=mean(NORM1ten);
NORMXvar1ten=var(NORM1ten) *(10/9); %sigma^2
histogram(NORMXbar1ten,50);
pause(2);

NORMXbar2ten=mean(NORM2ten);
NORMXvar2ten=var(NORM2ten)*(10/9); %s^2

sortNED1ten=sort(NEDXbar1ten,2);
sortNORM1ten=sort(NORMXbar1ten,2);

NEDalphaLim1ten=(sortNED1ten(25)+sortNED1ten(26))/2;
NEDalphaLim2ten=(sortNED1ten(975)+sortNED1ten(976))/2;
NORMalphaLim1ten=(sortNORM1ten(25)+sortNORM1ten(26))/2;
NORMalphaLim2ten=(sortNORM1ten(975)+sortNORM1ten(976))/2;

k=0;
for i=1:1000
    if (NEDXbar2ten(i)>NEDalphaLim1ten && NEDXbar2ten(i)<NEDalphaLim2ten)
        k=k+1;
    end
end
alphaNEDten=k/10;
k=0;
for i=1:1000
    if (NORMXbar2ten(i)>NORMalphaLim1ten && NORMXbar2ten(i)<NORMalphaLim2ten)
        k=k+1;
    end
end
alphaNORMten=k/10;

k=0;
for i=1:1000
    if (NEDXbar2ten(i)+0.2*miu  >NEDalphaLim1ten && NEDXbar2ten(i)+0.2*miu <NEDalphaLim2ten)
        k=k+1;
    end
end
betaNEDten=k/10;
k=0;
for i=1:1000
    if (NORMXbar2ten(i)+0.2*miu>NORMalphaLim1ten && NORMXbar2ten(i)+0.2*miu<NORMalphaLim2ten)
        k=k+1;
    end
end
betaNORMten=k/10;

zNEDten=(NEDXbar2ten-miu)/ sqrt( mean(NEDXvar1ten) / 10);
zNORMten=(NORMXbar2ten-miu)/ sqrt( mean(NORMXvar1ten) /10 );
tNEDten=(NEDXbar2ten-miu)./( sqrt( NEDXvar2ten/10 ) );
tNORMten=(NORMXbar2ten-miu)./( sqrt( NORMXvar2ten/10 ) );
% NED, NORMAL
k=0;
for i=1:1000
    if (abs(zNEDten(i))<za)
        k=k+1;
    end
end
alphaZNEDaccurancyten=k/10;
% NED, t-student
 k=0;
for i=1:1000
    if (abs(tNEDten(i))<ta)
        k=k+1;
    end
end
alphaTNEDaccurancyten=k/10;
% NORMAL, NORMAL
 k=0;
for i=1:1000
    if (abs(zNORMten(i))<za)
        k=k+1;
    end
end
alphaZNORMaccurancyten=k/10;
% NORMAL, t-student
 k=0;
for i=1:1000
    if (abs(tNORMten(i)<ta))
        k=k+1;
    end
end
alphaTNORMaccurancyten=k/10;

zNEDten=(NEDXbar2ten+0.2*miu-miu)/ sqrt( mean(NEDXvar1ten) / 10);
zNORMten=(NORMXbar2ten+0.2*miu-miu)/ sqrt( mean(NORMXvar1ten) /10 );
tNEDten=(NEDXbar2ten+0.2*miu-miu)./( sqrt( NEDXvar2ten/10 ) );
tNORMten=(NORMXbar2ten+0.2*miu-miu)./( sqrt( NORMXvar2ten/10 ) );
% NED, NORMAL
k=0;
for i=1:1000
    if (abs(zNEDten(i))<za)
        k=k+1;
    end
end
betaZNEDaccurancyten=k/10;
% NED, t-student
 k=0;
for i=1:1000
    if (abs(tNEDten(i))<ta)
        k=k+1;
    end
end
betaTNEDaccurancyten=k/10;
% NORMAL, NORMAL
 k=0;
for i=1:1000
    if (abs(zNORMten(i))<za)
        k=k+1;
    end
end
betaZNORMaccurancyten=k/10;
% NORMAL, t-student
 k=0;
for i=1:1000
    if (abs(tNORMten(i))<ta)
        k=k+1;
    end
end
betaTNORMaccurancyten=k/10;



%% BootStrap
bootRand1= rand(1,10);
bootRand2= rand(1,10);
bootNED1= (-1/lambda)*log(bootRand1);
bootNED2= (-1/lambda)*log(bootRand2);
bootNORM1= miu+ sigma*randn(1,10);
bootNORM2= miu+ sigma*randn(1,10);
bootMatNED1=zeros(10,1000);
bootMatNED2=zeros(10,1000);
bootMatNORM1=zeros(10,1000);
bootMatNORM2=zeros(10,1000);
% NED
for i=1:1000
    for j=1:10
        k=fix(10*rand+1);
        bootMatNED1(j,i)=bootNED1(k);
    end
end
bootNED1mean=( mean(bootMatNED1)-mean(bootNED1) ) ./ sqrt( var(bootMatNED1) / 10 );
sortBootNED1=sort(bootNED1mean,2);
bootNEDalphaLim1= (sortBootNED1(25)+sortBootNED1(26))/2;
bootNEDalphaLim2= (sortBootNED1(975)+sortBootNED1(976))/2;
for i=1:1000
    for j=1:10
        k=fix(10*rand+1);
        bootMatNED2(j,i)=bootNED2(k);
    end
end
bootNED2mean=( mean(bootMatNED2)-mean(bootNED2) ) ./ sqrt( var(bootMatNED2) / 10 );

% NORMAL
for i=1:1000
    for j=1:10
        k=fix(10*rand+1);
        bootMatNORM1(j,i)=bootNORM1(k);
    end
end
bootNORM1mean=( mean(bootMatNORM1)-mean(bootNORM1) ) ./ sqrt( var(bootMatNORM1) / 10 );
sortBootNORM1=sort(bootNORM1mean,2);
bootNORMalphaLim1= (sortBootNORM1(25)+sortBootNORM1(26))/2;
bootNORMalphaLim2= (sortBootNORM1(975)+sortBootNORM1(976))/2;
for i=1:1000
    for j=1:10
        k=fix(10*rand+1);
        bootMatNORM2(j,i)=bootNORM2(k);
    end
end
bootNORM2mean=( mean(bootMatNORM2)-mean(bootNORM2) ) ./ sqrt( var(bootMatNORM2) / 10 );

% Alpha accurancy
 %NED
k=0;
for i=1:1000
    if (bootNED2mean(i)>bootNEDalphaLim1 && bootNED2mean(i)<bootNEDalphaLim2)
        k=k+1;
    end
end
bootAlphaNEDaccurancy=k/10;
 %NORMAL
 k=0;
for i=1:1000
    if (bootNORM2mean(i)>bootNORMalphaLim1 && bootNORM2mean(i)<bootNORMalphaLim2)
        k=k+1;
    end
end
bootAlphaNORMaccurancy=k/10;

% Beta, Error Type 2
k=0;
for i=1:1000
    if (bootNED2mean(i)+0.2*miu > bootNEDalphaLim1 && bootNED2mean(i)+0.2*miu < bootNEDalphaLim2)
        k=k+1;
    end
end
bootBetaNED=k/10;
k=0;
for i=1:1000
    if (bootNORM2mean(i)+0.2*miu > bootNORMalphaLim1 && bootNORM2mean(i)+0.2*miu < bootNORMalphaLim2)
        k=k+1;
    end
end
bootBetaNORM=k/10;