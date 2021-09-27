%% Parameter Declaration
N=300;
N0=-2;
n=N0:N;
x=n.*0;  %Pre-allocation
x(n==0)=1; %delta[n]
delay=3; %Pause for figures
%% a
y=n.*0; %Pre-allocation
for ii=0:N
    i=ii-N0+1;  %Matrices indexes starts from 1
    y(i)=y(i-1)-0.9*y(i-2)+x(i)-x(i-2);
end
stem (n,y);
saveas(gcf,'/Users/user/Desktop/SS-MATLAB-HW2/Q3figs/fig1.fig','fig');
pause(delay);

%% b
b=[1 0 -1]; % 1 + 0/z - 1/z2
a=[1 -1 0.9]; % 1 - 1/z + 0.9/z2
h=impz(b,a,n);
ss=stepz(b,a,n);
s=n.*0;
s(-N0+1:N-N0+1)=ss(1:N+1);
stem (n,h);
hold on;
stem (n,s);
legend('Impulse response','Step response');
saveas(gcf,'/Users/user/Desktop/SS-MATLAB-HW2/Q3figs/fig2.fig','fig');
pause(delay);

%% c
x1=sin( (3*pi/8)*n + pi/16 ) + cos( (5*pi/8)*n );
f1= filter (b,a,x1);
hold off;
subplot (2,3,1);
stem(n,x1);
title('x1=sin + cos signal');
subplot(2,3,4);
stem (n,f1);
title('y1');
pause(delay);

%% d
n2=4*N0:4*N;  %Make a bigger signal to be finaly in a same range
xx1=sin( (3*pi/8)*n2 + pi/16 ) + cos( (5*pi/8)*n2 );
x2=downsample(xx1,4);
xx3=upsample(x1,4);
x3=xx3( (-4*N0+1)+N0 : (-4*N0+1)+ N );
subplot (2,3,2);
stem(n,x2);
title('Downsampled Input');
subplot(2,3,3);
stem (n,x3);
title('Upsampled Input');
f2= filter (b,a,x2);
f3= filter (b,a,x3);
subplot (2,3,5);
stem(n,f2);
title('Output');
subplot(2,3,6);
stem (n,f3);
title('Output');
saveas(gcf,'/Users/user/Desktop/SS-MATLAB-HW2/Q3figs/fig3.fig','fig');
pause(delay)

%% e
fr=freqz(b,a,315);
subplot(1,1,1);
plot (0:0.01:3.14,abs(fr));
saveas(gcf,'/Users/user/Desktop/SS-MATLAB-HW2/Q3figs/fig4.fig','fig');
pause(delay);
zplane(b,a);
saveas(gcf,'/Users/user/Desktop/SS-MATLAB-HW2/Q3figs/fig5.fig','fig');
pause(delay);

%% f
syms time input z
input = sin( (3*pi/8)*time + pi/16 ) + cos( (5*pi/8)*time );
X1=ztrans(input);
H=(1-z^-2)/(1-z^-1+0.9*z^-2);
Y1=X1*H;
output=iztrans(Y1,time);
y1=double(subs(output,time,n));
stem(n,y1);
saveas(gcf,'/Users/user/Desktop/SS-MATLAB-HW2/Q3figs/fig6.fig','fig');
%{
p1=0.5*sqrt(2-sqrt(2));
p2=0.5*sqrt(2+sqrt(2));
ax1=[1 2*p1 1];
bx1=[1 p1];
ax2=[1 -2*p1 1];
bx2=[sin(pi/16) p2*cos(pi/16)-p1*sin(pi/16)];
ax=conv(ax1,ax2);
bx=conv(ax1,bx2)+conv(bx1,ax2);
by=conv(b,bx);
ay=conv(a,ax);
[r p k]=residuez(b,a)
iztrans(r./(1-p/z));
%}