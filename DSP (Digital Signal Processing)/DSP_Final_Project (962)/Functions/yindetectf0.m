function f0 = yindetectf0(x,fs,ws,minf0,maxf0)
% Fundamental frequency detection function with yin algorithm
% x: input signal
% fs: sampling rate
% ws: integration window length
% minf0: minimum f0; f0 should not be below this frquency.
% maxf0: maximum f0; f0 should not be above this frquency.
% f0: fundamental frequency detected in Hz

maxlag = ws-2; % maximum lag 
th = 0.1; % set threshold
d = zeros(maxlag,1); % init variable (d(tau))
d2 = zeros(maxlag,1); % init variable (d’(tau))

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%                 Write your code here                        %%%%%%%
%%%%%%%                         _||_                                %%%%%%%
%%%%%%%                         \  /                                %%%%%%%
%%%%%%%                          \/                                 %%%%%%%
% Your job here is to implement Yin algorithm to detect the fundamental 
% frequency of a given frame. After calculating d’(tau) function, limit the
% search to the target range by minf0 and maxf0. Compute lags corresponding
% to these frequencies and set the values of d’(tau) in lags smaller than 
% the lag corresponding to maxf0 or lags greater than the lag corresponding 
% to minf0 to a high number like 100 to avoid detecting them as f0. Then 
% find minima of this function (d’(tau)). Consider a threshold of 0.1 for  
% this function. Pick the first lag from the found set of minima that has 
% a smaller function value than the threshold(0.1). If none of the found 
% minima has smaller function value than the threshold, pick the lag 
% corresponding to the smallest function value. Now you have a candidate lag  
% value. Use the d’(tau) function values before and after the candidate lag 
% value to perform a parabolic interpolation in order to refine the candidate  
% lag value (find where the minimum of this interpolated parabola occurs and
% set it as the candidate lag value). At last compute candidate frequency
% in Hz by dividing the sampling frequency by candidate lag value. If the 
% minimum of d’(tau) function is greater than 0.2, set f0 to 0.


% Default code:
%f0 = 0;
% 1 <= taw <= maxlag
t = 0;
x1 = x( t+1: t+ws );
for taw=1:maxlag
    x2 = x( t+1+taw: t+ws+taw );
    % taw=0 is unCalculated
    d(taw) = sum( (x1-x2).^2 );
end

% d2(0) = 1 is unCalculated
sumd = 0; % sumOfDs(0) = 0
for taw=1:maxlag
    sumd = sumd + d(taw);
    d2(taw) = taw*d(taw)/sumd;
end

tawMin = fs/maxf0;
tawMax = fs/minf0;

for taw=1:maxlag
    if( taw < tawMin )
        d2(taw) = 100;
    elseif( taw > tawMax )
        d2(taw) = 100;
    end
end

isPeak = (d2<th);

undefinitef0 = 0;
if( sum(isPeak)==0 )
    [minVal, condidateLag] = min(d2);
    if( minVal > 0.2 )
        undefinitef0 = 1;
    end
else
    j=1;
    while( isPeak(j)==0 )
        j=j+1;
    end
    condidateLag = j;
end

nfit = 2;
xfit = -nfit:1:nfit;
xfit = xfit(:);
xfity = condidateLag + xfit;
yfit = d2(xfity);
yfit = yfit(:);
%ffit = fit(xfit,yfit,'poly2');
polyFit = polyfit(xfit,yfit,2);
polyDiff = polyder(polyFit);
newLag = condidateLag - polyDiff(2)/polyDiff(1);

if( undefinitef0==1 )
    f0 = 0;
else
    f0 = fs/newLag;
end
%%%%%%%                         /\                                  %%%%%%%
%%%%%%%                        /  \                                 %%%%%%%
%%%%%%%                         ||                                  %%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end
