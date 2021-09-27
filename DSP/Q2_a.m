%% We use 0.001(s) steps for this plot   
t=-16:0.001:16;
d=-16:4:16;
y1=pulstran(t,d,'rectpuls',2/3);
y2=pulstran(t+2/3,d,'tripuls',2/3,-1);
y3=pulstran(t-2/3,d,'tripuls',2/3,1);
hold on
plot(t,y1);
plot(t,y2);
plot(t,y3);
title('Periodic Waveforms');
xlabel('Time(s)');
ylabel('Magnitude');
axis ([-16 16 0 1]);
grid on;