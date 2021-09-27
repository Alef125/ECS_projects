%% a: Load audio and Take 5 Secons of That
[audioA,fs]=audioread('/Users/user/Desktop/MT_94109205_3/Dvorak-Cello Concerto in B minor Op. 104.wav');
audioAOut = audioA(18.5*fs+1 : 23.5*fs);
clear audioA;
audiowrite('/Users/user/Desktop/MT_94109205_3/main_signal.wav',audioAOut,fs);

%% b: y[n] = x[n] + 0.5 * x[n-1]
% x[n-1] is a shifted signal by 1
N1=1;
audioB(5*fs+N1)=0;
audioB(1:5*fs)= audioAOut';
audioB(2:5*fs+N1)= audioB(2:5*fs+N1) + 0.5 * audioAOut;
audiowrite('/Users/user/Desktop/MT_94109205_3/main+0.5main.wav',audioB,fs);

%% c: H1(z) = 1 + (0.5/z) => H1(e^jw) = 1 + 0.5* e^-jw
bNUM = [1, 0.5];
aDEN = [1, 0];
[bNUM,aDEN] = eqtflength(bNUM,aDEN);
[zerosA,polesA,~] = tf2zp(bNUM,aDEN);
zplane(zerosA,polesA);
text(real(zerosA)+.1,imag(zerosA),'Zero')
text(real(polesA)+.1,imag(polesA),'Pole')
saveas(gca,'/Users/user/Desktop/MT_94109205_3/Q1TransferFunction.fig','fig');

%% d: H2(z) = z/(z + 0.5) => H2(e^jw) = 1/(1 + 0.5* e^-jw)
bNUM = [1, 0];
aDEN = [1, 0.5];
[bNUM,aDEN] = eqtflength(bNUM,aDEN);
[zerosA,polesA,kGain] = tf2zp(bNUM,aDEN);
zplane(zerosA,polesA);
text(real(zerosA)+.1,imag(zerosA),'Zero')
text(real(polesA)+.1,imag(polesA),'Pole')
saveas(gca,'/Users/user/Desktop/MT_94109205_3/Q1ReverseFunction.fig','fig');

%% e: Reverse the Signal in part b
syms zA nA H2A h2A;
H2A= zA/(zA+0.5);
h2A=iztrans(H2A,zA,nA);
h2Anum= double(subs(h2A,nA,0:20));
audioR=conv2(h2Anum,audioB);
audiowrite('/Users/user/Desktop/MT_94109205_3/revised_signal.wav',audioR,fs);
