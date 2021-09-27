function [delay, rxpck] = stc2atr(mode_struct, inf_size)
mode_delays = zeros(1, inf_size);
mode_rxpcks = zeros(1, inf_size);
for i = 1:inf_size
    mode_attributes = mode_struct.Children(2).Children(2*i);
    delay_string = mode_attributes.Attributes(1).Value;
    rxpcks_string = mode_attributes.Attributes(7).Value;
    mode_delays(i) = str2double(delay_string(2:end-2));
    mode_rxpcks(i) = str2double(rxpcks_string);
end
delay = mean(mode_delays) / 1000000000;
rxpck = mean(mode_rxpcks);
end

