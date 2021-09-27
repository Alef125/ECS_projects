%% Parameter Declaration
f1=1;   %For part c
f2=100; %For part c
n= -20:20; %For discrete ones (a,d,e)
t= -20 : 0.001 : 20;  %For continues ones (b,c)
un=fix( (sign(n)+1)/2 +0.5 );  %Or  discrete Heaviside 
ut= (sign(t)+1)/2; %Or continues Heaviside 

%% a
xa = n .* 0; %Pre-allocation
xa (n>=0 & n<=3)=1;
subplot(5,3,1);
stem (n,xa);
title('x');
ylabel('a');
un5 = n .* 0; %5-Right-Shifted Heaviside
un5(26:end)=1;
ha = (un-un5).*(exp(-n));
subplot(5,3,2);
stem (n,ha);
title('h');
ya0 = conv (xa,ha);
ya = ya0(21:61);
subplot(5,3,3);
stem (n,ya);
title('y');

%% b
ut11= ut; %1-Left-Shifted Heaviside
ut11(t>-1)=1;
ut1 = ut;
ut1(t<1)=0;
xb = -ut11 + 3*ut - 2*ut1;
subplot (5,3,4);
plot (t,xb);
ylabel('b');
mid=conv(ut-ut1,ut-ut1);
hb=mid(20001:60001);
%mid=conv(ut1,ut);
%hb = ut-mid(20001:60001)-ut1;
subplot (5,3,5);
plot (t,hb);
yb0 = conv (xb,hb);
yb = yb0(20001:60001);
subplot(5,3,6);
plot (t,yb);

%% c
xc = sin (2*pi*f1*t) + sin (2*pi*f2*t);
subplot (5,3,7);
plot (t,xc);
ylabel('c');
hc = sinc (2*f1*t);
hc (t<-10 | t>10)=0;
subplot (5,3,8);
plot (t,hc);
yc0 = conv (xc , hc);
yc = yc0 (20001:60001);
subplot(5,3,9);
plot (t,yc);

%% d
un10 = un;
un10(n<10) = 0;
xd = (un - un10) ./ (4.^n);
subplot (5,3,10);
stem (n,xd);
ylabel('d');
hd = (un - un10) ./ (3.^n);
subplot (5,3,11);
stem (n,hd);
yd0 = conv (xd,hd);
yd = yd0(21:61);
subplot (5,3,12);
stem (n,yd);

%% e
xe = n .* 0;
xe(n>=0 & n<=4)=1;
xe(23)=4;
subplot (5,3,13);
stem (n,xe);
ylabel('e');
he = n.*0;
he(21-1)=2;
he(21+0)=3;
he(21+1)=1;
subplot (5,3,14);
stem (n,he);
ye0 = conv (xe,he);
ye = ye0 (21:61);
subplot (5,3,15);
stem (n,ye);
