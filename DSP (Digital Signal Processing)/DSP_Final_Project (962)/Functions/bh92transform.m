function y = bh92transform(x,N)
% Calculate transform of the Blackman-Harris 92dB window
% x: bin positions to compute (real values)
% y: transform values
% N: DFT size

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%                 Write your code here                        %%%%%%%
%%%%%%%                         _||_                                %%%%%%%
%%%%%%%                         \  /                                %%%%%%%
%%%%%%%                          \/                                 %%%%%%%

% Your job is to calculate the Fourier transform of a zero-centered 
% Blackman-Harris 92 dB in given positions in the array x. At the end 
% normalize the transform valus by dividing them to (0.35875 * N).


% Default code:
y  = zeros(length(x),1);
a0 = 0.35875;
a1 = 0.48829;
a2 = 0.14128;
a3 = 0.01168;
a = [a0 a1 a2 a3];
n = 0:N-1;
cos0 = ones(N,1);
cos1 = cos(2*pi*n(:)/N);
cos2 = cos(4*pi*n(:)/N);
cos3 = cos(6*pi*n(:)/N);
cosAll = [cos0(:), cos1(:), cos2(:), cos3(:)];
cosAll = cosAll';
w = a*cosAll;
wFFT = fft(w);
for j = 1:length(x)
    % indexes start with 1
    index = x(j)+1;
    if( index<=0 )
        index = index + N;
    end
    y(j) = wFFT(index);
end

y = y / (0.35875*N);

%%%%%%%                         /\                                  %%%%%%%
%%%%%%%                        /  \                                 %%%%%%%
%%%%%%%                         ||                                  %%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end
