function [ output_signal ] = lowpass_filter( input_signal , freq_pass )

sampeling_rate = 240

f = (freq_pass)/ sampeling_rate

d = fdesign.lowpass('Fp,Fst,Ap,Ast',f,f+0.01,1,60);

Hd = design(d,'equiripple');

output_signal = filter(Hd,input_signal);


end

