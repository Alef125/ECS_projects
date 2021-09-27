%% We use 0.001(s) steps for this plot 
delta=0.01;
n=5/delta+1;   % Number of random numbers that are produced
D=1;           % Domain of noise signal
t=0:delta:5;
Noise=2*D*( rand(1,n)-0.5 );
x=sin(4*pi*t);
y=x+Noise;
plot(t,y);
xlabel('t');
ylabel('x(t)');
title('Diagram');
legend('x');
axis([0 5 -1-D 1+D]);



%% We use 0.001(s) steps for this plot 
delta=0.001;
n=5/delta+1;
t=0:delta:5;
x=sin(4*pi*t);
plot(t,x);
xlabel('t');
ylabel('x(t)');
title('Sine Signal with period 2');
legend('x(t)');
axis([0 5 -1 1]);