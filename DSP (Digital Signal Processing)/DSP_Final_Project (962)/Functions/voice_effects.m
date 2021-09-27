function output = voice_effects(selector, s, s_win,...
     input, C_h)
% output = voice_effects(selector, s, s_win,...
%    input, C_h)
%
% This function is designed to implement two simple nonlinear voice effects
% using the idea of phase vocoder.
% The first one is hoarsening effect, which by adding a random phase makes 
% the input voice harsh and rough. 
% The second one is robotizing effect, which by changing the phase array of
% each window to zero makes the input voice sound like a robot's one.
%
% Inputs:
% selector         1 : Performs hoarsening effect
%                  2 : Performs robotizing effect
% s                  : Step size that in each step the input window goes
%                      forward by this factor
% s_win              : Window size
% input              : The input file
% C_h                : (hoarsening coeff): A number between 0 (no effect) 
%                      and 1 (max effect) which indicates the level of 
%                      hoarsening.
%                       
% Outputs:
% output             : The output file


%% Initializing
l            = length(input);

% Default win
win          = hanning(s_win);
% My Win
%win          = rectwin(s_win);

% Zero padding to become sure the input signal has more than s_win elements, 
% and with this s_win and step size it will not exceed number of elements.
% You had written a wrong padding. n_seg is not int now
%

% Correct one:
endPadding = mod( (s-mod(l,s)) , s );
input        = [zeros(s_win,1);input;zeros(endPadding,1)];
% Normalizing the input signal
input        = input/max(abs(input));

% Number of segments
% Wrong
%n_seg        = (length(input)-s_win)/s;
% Correct one:
n_seg        = (length(input)-s_win)/s + 1;

output       = zeros(length(input),1);


    
    switch selector 
        case 1
            %% Adding hoarsening effect to the input signal

            pointer = 0;
            for k   = 1:n_seg
                
                % Getting the input segment multiplied by window
                segment    = input((k-1)*s+1:(k-1)*s+s_win).*win;
                
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                %%%%%%%           Write your code here              %%%%%%%
                %%%%%%%                   _||_                      %%%%%%%
                %%%%%%%                   \  /                      %%%%%%%
                %%%%%%%                    \/                       %%%%%%%

                % Your job has two parts here:
                % 1: Perform the FFT of the 'segment' and then calculate
                % the phase (phi) and amplitude (a) of it. Pay attention to
                % the ifftshift in the IFFT part, which means you had to
                % use fftshift in your FFT.
                % 2: Produce the rand_phase vector. A vector with the same
                % size as the phi.

                % Available variables:
                % segments:                     Is the input signal
                % 'hoarsening_coeff':           Indicates the range of
                %                               output random phase
                %
                % Outputs of this part of code:
                % phi:                      	Is the phase vector of FFT
                %                               of segment.
                % a:                            Is the amplitude vector of
                %                               FFT of segmetn.
                % rand_phase                    Is a random array with
                %                               values in the range    
                %                               [-pi*C_h : pi*C_h] 

                % Default code:
                segmentFFT(:) = fft( segment );
                phi(:)        = angle(segmentFFT);
                a(:)          = abs(segmentFFT);
                rand_phase(:) = C_h*( pi - 2*pi*rand(size(phi(:),2)) );
                
                %{
                % alternative
                phi        = angle(segment);
                a          = abs(segment);
                %}


                %%%%%%%                    /\                       %%%%%%%
                %%%%%%%                   /  \                      %%%%%%%
                %%%%%%%                    ||                       %%%%%%%
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                
                % Adding random phase to the original one               
                phi        = phasewrapper(phi(:)+rand_phase(:));
                
                % Reconstructing signal with new phase
                ft(:)         = (a(:).* exp(1i*phi(:)));
                
                % Performing IFFT and producing the output of each segment
                result     = ifftshift(real(ifft(ft(:)))).*win(:);
    
                % Default Win, with overlap
                output(pointer+1:pointer+s_win) = ...
                             output(pointer+1:pointer+s_win) + result;
   
                % My own one
                %output(pointer+1:pointer+s_win) = result(:);
                
                pointer    = pointer + s;
    
            end

            % Normalizing the output
            output = output/max(output);


       case 2
           %% Adding robotizing effect to the input signal
               
            pointer = 0;
            for k   = 1:n_seg
                % Getting the input segment multiplied by window
                segment = input((k-1)*s+1:(k-1)*s+s_win).*win;
                
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                %%%%%%%           Write your code here              %%%%%%%
                %%%%%%%                   _||_                      %%%%%%%
                %%%%%%%                   \  /                      %%%%%%%
                %%%%%%%                    \/                       %%%%%%%

                % Your job has two parts here:
                % 1: Perform the FFT of the 'segment' and then make the
                % phase of its elements equal to zero.
                % 2: Perform the IFFT of the phase removed signal. Pay
                % attention to the fact that elements of the 'output'
                % signal should be real numbers. 

                % Available variable:
                % segments:                     Is the input signal
                %
                % Outputs of this part of code:
                % result:                       The IFFT of phase-zeroed 
                %                               signal 

                % Default code:
                segmentFFT = fft( segment );
                a          = abs(segmentFFT);
                ft = a;
                
                result  = fftshift(real(ifft(ft))).*win;
                
                %{
                % alternative
                result  = segmnet;
                %}
                

                %%%%%%%                    /\                       %%%%%%%
                %%%%%%%                   /  \                      %%%%%%%
                %%%%%%%                    ||                       %%%%%%%
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
                % Default win, with overlap
                output(pointer+1:pointer+s_win) = ...
                             output(pointer+1:pointer+s_win) + real(result);
   
                % My own one
                %output(pointer+1:pointer+s_win) = real(result);
   
                pointer = pointer + s;
    
            end

            % Normalizing the output
            output = output/max(output);

    end

end

