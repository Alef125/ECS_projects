%% Low-pass Filter (15Hz)
%Sig=EEG_Signal(1,:,1);
%Signal=lowpass_filter(Sig,15);
%save('Proccessed-Signal',Signal);

Signal= circshift(New_Signal,-175,2);

[acor,lag] = xcorr(Signal(1,:,1),EEG_Signal(1,:,1));
[~,Ind] = max(abs(acor));
lagging= lag(Ind);

