%% Parameter Declaration
fc=100000;
fm=1000;
a=0.5;
t=0 : 0.000001 : 0.001;

%% Modulation
m = sin(2*pi*fm*t);
s = (1 + a*m).* sin(2*pi*fc*t);

%% Plot
plot(t,s);
xlabel('t');
ylabel('S(t)');
title('Modulated Signal');
legend('Signal');
axis([0 0.001 -1-a 1+a]);