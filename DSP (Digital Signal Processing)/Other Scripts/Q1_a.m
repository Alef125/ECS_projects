%% We use 0.01(s) steps for this plot
t =-1:0.01:10;
T=1;
u=heaviside(t);
x1=(1-exp(-t*T)).*u;
plot(t,x1);
xlabel('t');
ylabel('x1(t)');
title('Diagram 1, x1(t)=(1-e^(-tT)).u(t)');
legend('x1(t)');
axis([-1 10 0 1]);