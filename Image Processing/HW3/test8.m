function Temp=test8(I,i,j);
    x=size(I,2);
    y=size(I,1);
    n=25;
    nn=5;
    J=zeros(y,x);
    J=J+200;
    G1=I([i-n:i+n],[j-n:j+n],:);
    for ii=n+1:nn:y-n;
        for jj=n+1:nn:x-n
            G2=I([ii-n:ii+n],[jj-n:jj+n],:);
            J(ii,jj)=test9(G1,G2,n);
        end
    end
    JJ=J<2;
    k = sum(sum(JJ));
    r = randi(k,1,1);
    counter=0;
    quit=0;
    p1=0;
    p2=0;
    for ii=n+1:nn:y-n;
        for jj=n+1:nn:x-n       
            if ( JJ(ii,jj) )
                counter=counter+1;
            end        
            if ( counter== r )
                p1=ii;
                p2=jj;
                quit=1;
                break;
            end
        end        
        if (quit)
            break;
       end
    end
    Temp=I([p1-n:p1+n],[p2-n:p2+n],:);
end