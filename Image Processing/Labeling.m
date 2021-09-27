%% Labeling
% (This Part of Code is Based on The "Telephone Caller" Introduced in one_
% _of MATLAB HWs and promoted with some of friends)
charLabels=zeros(55,12);
chart = {'A' 'B' 'C' 'D' 'E' 'F' ; 
         'G' 'H' 'I' 'J' 'K' 'L' ;
         'M' 'N' 'O' 'P' 'Q' 'R' ;
         'S' 'T' 'U' 'V' 'W' 'X' ;
         'Y' 'Z' '1' '2' '3' '4' ;
         '5' '6' '7' '8' '9' '_'};
for n=1:55
    for i=1:6
        for j=1:6
            if ( EEG_TargetChar(n) == chart{i,j} )
                charLabels(n, i+6 )=1;  %Becaus row numbers are 7 to 12
                charLabels(n, j )=1;
                break;
            end
        end
    end 
end
