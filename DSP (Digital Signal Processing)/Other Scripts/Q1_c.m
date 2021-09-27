%% We use 0.01(s) steps for this plot
t =-1:0.01:10;
T=1;
f0=2;
u=heaviside(t);
x1=(1-exp(-t*T)).*u;
x2=sin(2*pi*f0*t);
x3=x1.*x2;
plot(t,x3);
xlabel('t');
ylabel('x3(t)');
title('Diagram 3, x3(t)=(1-e^(-tT)).sin(2.PI.f0.t).u(t)');
legend('x3(t)');
axis([-1 10 -1 1]);