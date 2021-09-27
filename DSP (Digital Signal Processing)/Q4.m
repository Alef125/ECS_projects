%% a: Load audio and determine sampling rate
[y fs]=audioread('/Users/user/Desktop/sound.wav');
display(fs);

%% b: Plot signal in real time
N=size(y,1);
T=N/fs;
t=1/fs:1/fs:T;
subplot(3,1,1);
plot(t,y');
xlabel('t');
ylabel('Sound(t)');
title('Main Voice');
legend('Signal');
axis([0 T -0.5 0.5]);

%% c: Find Maximum amplitude of signal
M=max(abs(y));

%% d: Add tone to main audio signal
f=4000;
x=M*sin(2*pi*f*t);
yy=y'+x;
subplot(3,1,2);
plot(t,yy);
xlabel('t');
ylabel('Sound(t)');
title('Sinosoid added Voice');
legend('Signal');
axis([0 T -1 1]);
%sound(yy',fs);

%% e: Save produced audio in part d
audiowrite('/Users/user/Desktop/SS-MATLAB-HW1/Q4/sound_tone.wav',yy',fs);

%% f: Add noise to main audio signal
D=M/3;    %Domain
Noise=2*D*( rand(1,N)-0.5 );
yyy= y'+ Noise;
subplot(3,1,3);
plot(t,yyy);
xlabel('t');
ylabel('Sound(t)');
title('Noisy Voice');
legend('Signal');
axis([0 T -0.7 0.7]);
%sound(yyy',fs);

%% g: Save produced audio in part f
audiowrite('/Users/user/Desktop/SS-MATLAB-HW1/Q4/sound_noise.wav',yyy',fs);