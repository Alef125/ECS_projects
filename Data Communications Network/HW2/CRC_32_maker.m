function crc = CRC_32_maker(data)
%data_bin_size = 4 * size(data, 2);
data_bin = '';
for i = 1:size(data,2)
    dc = dec2bin(hex2dec(data(i)));
    for j = 1:4-size(dc,2)
        dc = strcat('0', dc);
    end
    data_bin = strcat(data_bin, dc );
end
%data_bin = dec2bin(hex2dec(data))
%for i = 1:data_bin_size-size(data_bin, 2)
%    data_bin = strcat('0', data_bin);
%end
data_bin2 = data_bin;
for i = 1:8:size(data_bin,2)
    data_bin2(i:i+7) = fliplr(data_bin(i:i+7));
end
data_bin = strcat(data_bin2, '00000000000000000000000000000000');
for i = 1:32
    if data_bin(i)=='0'
        data_bin(i)='1';
    else
        data_bin(i)='0';
    end
end
% crc = '11111111111111111111111111111111';
crc = '00000000000000000000000000000000';
for i = 1:size(data_bin,2)
    crc = next_32_bits(crc, data_bin(i));
end
% for i = 1:32
%     crc = next_32_bits(crc, '0');
% end
dec2hex(bin2dec(crc));
for i = 1:32
    if crc(i)=='0'
        crc(i)='1';
    else
        crc(i)='0';
    end
end
%dec2hex(bin2dec(crc))
%crc = fliplr(crc);
crc = dec2hex(bin2dec(crc));
end

