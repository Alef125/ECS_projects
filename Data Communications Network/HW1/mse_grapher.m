function mse = mse_grapher(N, code_A, code_B, p)

chip_size = length(code_A);

data_A = 1 - 2 * (round(rand(1,N)));
data_B = 1 - 2 * (round(rand(1,N)));

signal_length = N * chip_size;
signal_A = zeros(1,signal_length);
signal_B = zeros(1,signal_length);
for i = 1:N
    for j = 1:chip_size
        signal_A((i-1) * chip_size + j) = data_A(i) * code_A(j);
        signal_B((i-1) * chip_size + j) = data_B(i) * code_B(j);
    end
end

resulting_signal = signal_A + signal_B;

flipping = 1 - 2 * (ceil(rand(1,signal_length) - (1-p)));
receiving_signal = flipping .* resulting_signal;

decoder_A = code_A;
decoder_B = code_B;
decoded_A = (1/chip_size) * ((reshape(receiving_signal, chip_size, N))' * decoder_A')';
decoded_B = (1/chip_size) * ((reshape(receiving_signal, chip_size, N))' * decoder_B')';

mse = sum((decoded_A - data_A).^2) + sum((decoded_B - data_B).^2);

end

