%% Parameter Declaration
k1= 0.2; %m2/s
k2= 0.2; %m2/s
A1=4; %m2
A2=2; %m2
% Equations:  (k1/A1=1/20 , k2/A2=1/10)
%  r1[n+1] = T/20 r0[n] - (1-T/20) r1[n]
%  r2[n+1] = T/10 r1[n] - (1-T/10) r2[n]
T=1;
t=0 : T : 60;

%% Solve r1
r1 = t .* 0; %Pre-allication
r0 = (t .* 0)+0.1; %r0[n]=constant=0.1
for i=1:(60/T);
    r1(i+1)= (T/20) * r0(i) + (1-T/20)* r1(i);
end
hold on;
stem (t,r1);
%% Solve r2
r2 = t .* 0;
for i=1:(60/T);
    r2(i+1)= (T/10) * r1(i) + (1-T/10)* r2(i);
end
stem (t,r2);
legend('r1','r2');
