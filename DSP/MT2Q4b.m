function Dial=MT2Q4b()
%% Parameter Declaration
dialpad={'1' '2' '3' 'A';
         '4' '5' '6' 'B';
         '7' '8' '9' 'C';
         '*' '0' '#' 'D'};
fL=[697 770 852 941]' * [1 1 1 1];
fH=[1 1 1 1]' * [1209 1336 1477 1633];
fs=8000;
T=0.25;
DT=0.3;
t=0 : 1/fs : 5*DT;
Dial='11111';
S=audioread('/Users/user/Desktop/SS-MATLAB-HW2/Dial.wav');

%% Modulation
for i=1:5
    ti=(i-1)*DT : 1/fs : (i-1)*DT+T;
    si=S( (i-1)*DT<=t & t<=(i-1)*DT+T );
    F=fft(si);
    F(abs(F)<400)=0;
    F(abs(F)>=400)=1;
    p=1;
    while(F(p)==0)
        p=p+1;
    end
    f1=p/T;
    p=p+1;
    while(F(p)==0)
        p=p+1;
    end
    f2=p/T;
    for j=1:4
        for jj=1:4
            if ( (abs(f1-fL(j,jj))<10) && (abs(f2-fH(j,jj))<30) )
                Dial(i)=dialpad{j,jj};
                break
            end
        end
    end
end
end