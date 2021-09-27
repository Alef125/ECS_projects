clc
clear
inf_size = 8;

% models
mode1_struct = xml2struct( 'Outputs/HW3_94109205_Mode_1_flow.xml' );
mode2_struct = xml2struct( 'Outputs/HW3_94109205_Mode_2_flow.xml' );
mode3_struct = xml2struct( 'Outputs/HW3_94109205_Mode_3_flow.xml' );
mode4_struct = xml2struct( 'Outputs/HW3_94109205_Mode_4_flow.xml' );
mode5_struct = xml2struct( 'Outputs/HW3_94109205_Mode_5_flow.xml' );
mode6_struct = xml2struct( 'Outputs/HW3_94109205_Mode_6_flow.xml' );
mode7_struct = xml2struct( 'Outputs/HW3_94109205_Mode_7_flow.xml' );

%inf_size = (size(mode1_struct.Children(2).Children(), 2) - 1) / 2

[mode1_delay, mode1_rxpck] = stc2atr(mode1_struct, inf_size);
[mode2_delay, mode2_rxpck] = stc2atr(mode2_struct, inf_size);
[mode3_delay, mode3_rxpck] = stc2atr(mode3_struct, inf_size);
[mode4_delay, mode4_rxpck] = stc2atr(mode4_struct, inf_size);
[mode5_delay, mode5_rxpck] = stc2atr(mode5_struct, inf_size);
[mode6_delay, mode6_rxpck] = stc2atr(mode6_struct, inf_size);
[mode7_delay, mode7_rxpck] = stc2atr(mode7_struct, inf_size);

all_delays = [mode1_delay, mode2_delay, mode3_delay, mode4_delay, mode5_delay, mode5_delay, mode7_delay];
all_rxpcks = [mode1_rxpck, mode2_rxpck, mode3_rxpck, mode4_rxpck, mode5_rxpck, mode5_rxpck, mode7_rxpck];

tr = [25.4, 36.1, 65.0, 128.9, 265.2, 514, 1024.5];

figure;
plot(tr, all_delays);
title("delay");
xlabel('Tarffic, Kbps');
ylabel('sec');

figure;
plot(tr, all_rxpcks);
title("Throughput");
xlabel('Tarffic, Kbps');
ylabel('sec');