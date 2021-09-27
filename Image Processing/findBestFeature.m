EEE= zeros(1, Nf);
for i=1:55
    for j=1:12
        for k=1:Nf
            EEE(k)=EEE(k)+  abs( charLabels(i,j) - allSvmLabels( 12*(i-1)+j , k) );
        end
    end
end