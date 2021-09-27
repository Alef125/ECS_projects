function S=MT2Q4a(Dial)
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
ti=0 : 1/fs : T;
S=t.*0;

%% Modulation
for i=1:5
    for j=1:4
        for k=1:4
            if (dialpad{j,k}==Dial(i))
                %ti=(i-1)*DT : 1/fs : (i-1)*DT+T;
                S( (i-1)*DT<=t & t<=(i-1)*DT+T ) = sin (2*pi*fL(j,k)*ti) + sin (2*pi*fH(j,k)*ti);
            end
        end
    end
end
plot(t,S);
audiowrite('/Users/user/Desktop/SS-MATLAB-HW2/Dial.wav',S,fs);
end