%% We use 0.001(s) steps for this plot 
delta=0.001;  
n=5/delta+1;   % Number of random numbers that are produced
D=1;           % Domain of noise signal
t=0:delta:5;
Noise=2*D*( rand(1,n)-0.5 );
plot(t,Noise);
xlabel('Time(s)');
ylabel('Noise(t)');
title('Noise signal');
legend('N(t)');
axis([0 5 -D D]);