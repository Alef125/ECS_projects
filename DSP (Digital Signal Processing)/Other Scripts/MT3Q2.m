%% a: Reading audio and Plotting Frequency Spectrum
[audioA,fs]=audioread('/Users/user/Desktop/MT_94109205_3/Piano.wav');
SamplesA = size(audioA,1);
durationA= SamplesA/fs; %seconds               
fourierA = fftshift(fft(audioA)); % Fourier Transform
f= fs* ( (0:SamplesA-1)/SamplesA ) - fs/2;  %from -fs/2 to fs/2 and equal size with audioA
% Plot the spectrum:
plot(f, abs(fourierA)/durationA );
xlabel('Frequency (in hertz)');
title('Magnitude Response');
saveas(gca,'/Users/user/Desktop/MT_94109205_3/FrequencySpectrum.fig','fig');

%% b: Listening with fs=44100
%sound(audioA,fs);

%% c: Listening with fs=14000;
%sound(audioA,14000);
audiowrite('/Users/user/Desktop/MT_94109205_3/PartC.fs=14000.wav',audioA,14000);

%% d: Filtering The Sound as Upsampling, and Playing with fs=44100
[b , a]= butter(3,0.02,'low');
audioB = filter(b,a,audioA);
%Spectrum:
fourierB = fftshift(fft(audioB)); % Fourier Transform
plot(f, abs(fourierB)/durationA );
xlabel('Frequency (in hertz)');
title('Magnitude Response');
saveas(gca,'/Users/user/Desktop/MT_94109205_3/FilteredFrequencySpectrum.fig','fig');

%sound(3*audioB,44100);
audiowrite('/Users/user/Desktop/MT_94109205_3/PartD.fs=44100.wav',3*audioB,44100);

%% e: Playing Filtered Sound with fs=14000
%sound(3*audioB,14000);
audiowrite('/Users/user/Desktop/MT_94109205_3/PartE.fs=14000.wav',3*audioB,14000);