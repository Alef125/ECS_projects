%% We use 0.001(s) steps for this plot 
delta=0.001;
n=5/delta+1;   % Number of random numbers that are produced
D=0.2;         % Domain of noise signal
t=0:delta:5;
Noise=2*D*( rand(1,n)-0.5 );
x=sin(4*pi*t);
y=x+Noise;
subplot (2,1,1);
plot(t,x);
xlabel('t');
ylabel('x(t)');
title('x(t) = sin(4Pi*t)');
legend('x');
axis([0 5 -1-D 1+D]);
subplot(2,1,2);
plot(t,y);
xlabel('t');
ylabel('y(t)');
title('y(t)=x(t) + noise');
legend('y');
axis([0 5 -1-D 1+D]);

