%% We use 0.01(s) steps for this plot
t =-1:0.01:10;
f0=2;
u=heaviside(t);
x2=sin(2*pi*f0*t);
plot(t,x2);
xlabel('t');
ylabel('x2(t)');
title('Diagram 2, x2(t)=sin(2.PI.f0.t)');
legend('x2(t)');
axis([-1 10 -1 1]);