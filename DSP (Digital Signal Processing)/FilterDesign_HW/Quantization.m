function [output]=Quantization(input,B)
%Quantization perform quantization
%   output = Quantization(input,B) quantize input signal to B bits;

%   preallocate output for speed
% -----------------------------------------
output = zeros(1,length(input));

% Enter your code here
%----------------------------------
delta = 1 / pow2(B);
output = round( input/delta ) * delta;

end