function bank = myownfilt_bank(N,L,Win,is_PM,Fs,B)
%FILT_BANK	Filter bank generator template
%   BANK = FILT_BANK(N,L,winType,is_PM,Fs,B) generates a bank of non-overlapping filters where
%   N is the number of filter bands, L is the length of each FIR filter,  Fs is
%   the sampling frequency in Hz,B is the width of each band in Hz and Win is 
%
%   window type :  'kaiser' or 'rectangular'
%
%   BANK is an LxN matrix, where each of the N columns of BANK contains an L-point FIR
%
%   BANK = FILT_BANK(N,L,,winType,is_PM,Fs) automatically selects the bandwidth B so that the N
%   filters span the spectrum from 0 Hz to 3600 Hz.
%
%   BANK = FILT_BANK(N,L,winType,is_PM) sets Fs to 8000 Hz, and automatically selects the
%   bandwidth B so that the N filters span the spectrum from 0 Hz to 3600 Hz.
%

% Set Defaults
%-------------
if nargin < 6
    B       = 3600/N;  % set default width of each band in Hz
end
if nargin < 5
    Fs      = 8000;   % set default sampling frequency in Hz
end

start       = B/2;     % First center freq. in Hz
freqDistance = 3750/N;      % Distance Between Frequencies  

% preallocate output for speed
bank        = zeros(L,N);

% x-axis vector for plotting and saving filterBank figures
% note that you should change it into correct vector for plotting
freqAxis    = ( (1:L) - 1 ) /L *Fs;

% Cut-Off ratio of Filter
Wn = B / Fs; % = (B/2) / (Fs/2) 

if(~is_PM)
    % Design a prototype lowpass filter
    %----------------------------------
    lpf  = zeros(1,L); 
    switch Win
        case 'kaiser'
    %        create your low pass filter using kaiser window ...
            beta = 3;  
            lpf = fir1(L-1, Wn, kaiser(L,beta)); 
        case 'rectangular'
    %       create your low pass filter using rectangular window ...
            lpf = fir1(L-1, Wn, rectwin(L));
    end

    lpf = lpf(:);

    % Create bandpass filters
    %------------------------
    for i= 1:N
        freqi = (i-1)*freqDistance + start;
        wc_i = 2*pi*freqi;
        wn_i = wc_i/Fs;
        freqModuler = cos( wn_i*(1:L) );
        bank(:,i) = lpf(:) .* freqModuler(:);
    end

else
    % Design an appropriate Parks-McClellan filter 
    %----------------------------------
    pmOrder = L-1;
    eps = 40; % EPSILON = 10 HZ;
    f0 = B;
    FedgesRatio = [0, f0-eps, f0+eps, (Fs/2)] / (Fs/2);
    amplitudes= [1,1,0,0];
    bank(:,1) = firpm(pmOrder, FedgesRatio, amplitudes);
    for i=2:N
        f1 = start + (i-1)*freqDistance - B/2;
        f2 = start + (i-1)*freqDistance + B/2;
        FedgesRatio = [0, f1-eps, f1+eps, f2-eps, f2+eps, (Fs/2)] / (Fs/2);
        amplitudes= [0,0,1,1,0,0];
        bank(:,i) = firpm(pmOrder, FedgesRatio, amplitudes);
    end
    
end
                                
% plotting and saving frequency response of your filterBank
%---------------------------------------------------------

for i = 1:N
    figure(i)
    plot(freqAxis,abs(fftshift(fft(bank(:,i)))));
    xlabel('f(Hz)');
    ylabel('|H(e^{jw})|');
    title(['magnitude of frequency response of band' ,num2str(i)]); 
    if(~is_PM)
        switch Win
            case 'kaiser'
                if exist(['./filtBank figures/Kaiser/',num2str(N),'/',num2str(L)],'dir')~= 7  % checking directory existence
                    mkdir(['./filtBank figures/Kaiser/',num2str(N),'/',num2str(L)]);            % making directory
                end
                hgsave(['./filtBank figures/Kaiser/' , num2str(N),'/',num2str(L),'/band',num2str(i),'.fig']);

            case 'rectangular'
                if exist(['./filtBank figures/Rectangular/',num2str(N),'/',num2str(L)],'dir')~= 7
                    mkdir(['./filtBank figures/Rectangular/',num2str(N),'/',num2str(L)]);
                end
                hgsave(['./filtBank figures/Rectangular/' , num2str(N),'/',num2str(L) ,'/band',num2str(i),'.fig']);
        end
    else
        % saving in different folders based on order of PM filter 
        if exist(['./filtBank figures/P_M/',num2str(pmOrder),'/',num2str(L)],'dir')~= 7  % checking directory existence
            mkdir(['./filtBank figures/P_M/',num2str(pmOrder),'/',num2str(L)]);            % making directory
        end
        hgsave(['./filtBank figures/P_M/' , num2str(pmOrder),'/',num2str(L),'/band',num2str(i),'.fig']);
    end
end
end
