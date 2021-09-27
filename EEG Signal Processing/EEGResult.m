% function resultChar =EEGResult( allSvmLabels, Nf )
    newSvmLabels= zeros(55,12);
    sortIndex=zeros(55,12);
    row= zeros(1,55);
    column= zeros(1,55);
    ErrorChar=zeros(1);
    resultChar(55)='t';
    % Merging the result 
        for i=1:55
            for k=1:12
                newSvmLabels(i, k) = newSvmLabels(i, k)+ allSvmLabels( 12*(i-1)+ k) ;
            end
        end
    % Defining the Rows and Colomns for Characters
        for i=1:55
            [~ , column(i)] =max( newSvmLabels(i,1:6) );
            [~ , row(i)] =max( newSvmLabels(i,7:12) );
            newSvmLabels(i,:)=zeros(1,12);
            newSvmLabels(i,row(i)+6)=1;
            newSvmLabels(i,column(i))=1;
        end 
    % Findin Characters
    chart = {'A' 'B' 'C' 'D' 'E' 'F' ; 
             'G' 'H' 'I' 'J' 'K' 'L' ;
             'M' 'N' 'O' 'P' 'Q' 'R' ;
             'S' 'T' 'U' 'V' 'W' 'X' ;
             'Y' 'Z' '1' '2' '3' '4' ;
             '5' '6' '7' '8' '9' '_'};
   for n =55:-1:1
                resultChar(n)= chart{row(n),column(n)};
                if (resultChar(n) ~= EEG_TargetChar(n))
                     ErrorChar=ErrorChar+1/55;
                end
    end
%end
