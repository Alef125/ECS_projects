%% Definations
chip_size = 4;
code_A = 1 - ([0, 0, 0, 0])*2;
code_B = 1 - ([0, 0, 1, 1])*2;

%% Generating Data
N = 100; % Number of transmitting bits
data_A = 1 - 2 * (round(rand(1,N)));
data_B = 1 - 2 * (round(rand(1,N)));

%% Transformin Data to Signal
signal_length = N * chip_size;
signal_A = zeros(1,signal_length);
signal_B = zeros(1,signal_length);
for i = 1:N
    for j = 1:chip_size
        signal_A((i-1) * chip_size + j) = data_A(i) * code_A(j);
        signal_B((i-1) * chip_size + j) = data_B(i) * code_B(j);
    end
end

%% Resulting Transmittin Signal
resulting_signal = signal_A + signal_B;

%% Channel

% Bernoulli Aditive Noise Effect:
p = 0.125; % Bernoulli Probability to flip
flipping = 1 - 2 * (ceil(rand(1,signal_length) - (1-p)));

% Shifting Effect
n_shift = 5;
alpha = 0.8;
signal_shift = zeros(1, signal_length);
signal_shift(n_shift+1:end) = alpha * resulting_signal(1:end-n_shift);
receiving_signal = flipping .* (resulting_signal + signal_shift);

%% Decoding Signals
% Error Correction:
m_shift = n_shift+1;
fine_signal = receiving_signal - alpha * [zeros(1,m_shift), receiving_signal(1:end-m_shift)] + ...
                                 alpha^2 * [zeros(1,2*m_shift), receiving_signal(1:end-2*m_shift)]-...
                                 alpha^3 * [zeros(1,3*m_shift), receiving_signal(1:end-3*m_shift)]+...
                                 alpha^4 * [zeros(1,4*m_shift), receiving_signal(1:end-4*m_shift)];
decoder_A = code_A;
decoder_B = code_B;
decoded_A = (1/chip_size) * ((reshape(fine_signal, chip_size, N))' * decoder_A')';
decoded_B = (1/chip_size) * ((reshape(fine_signal, chip_size, N))' * decoder_B')';

% decoded_A = round(decoded_A);
% decoded_B = round(decoded_B);

%% Error Estimation
mse = sum((decoded_A - data_A).^2) + sum((decoded_B - data_B).^2)

%% Graphing
%{
itter = 1000; % Number of Test Itterations
p = rand(1, itter);
all_mse = zeros(1, itter);
for i = 1:itter
    all_mse(i) = mse_grapher(N, code_A, code_B, p(i));
end
scatter( p, all_mse / (2*chip_size*N), 10 );
xlabel('p');
ylabel('mse / # all chips');
title('Channel Flipping Model'); 
%}
