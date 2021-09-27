%% We use 0.01(s) steps for this plot
t =-1:0.01:10;
T=1;
f0=2;
u=heaviside(t);
x1=(1-exp(-t*T)).*u;
x2=sin(2*pi*f0*t);
%% plotting x1(t)
subplot(2,1,1);
plot(t,x1,'k');
xlabel('t');
ylabel('x1(t)');
title('Diagram 1, x1(t)=(1-e^(-tT)).u(t)');
legend('x1(t)');
axis([-1 10 0 1]);
%% plotting x2(t)
subplot(2,1,2);
plot(t,x2,'m');
xlabel('t');
ylabel('x2(t)');
title('Diagram 2, x2(t)=sin(2.PI.f0.t)');
legend('x2(t)');
axis([-1 10 -1 1]);


%%