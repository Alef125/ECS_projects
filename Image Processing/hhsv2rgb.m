function Z=hhsv2rgb(I);
    H=I(:,:,1);
    S=I(:,:,2);
    V=I(:,:,3);
    if S==0                   
        R=V*255;
        G=V*255;
        B=V*255;
    else
        h=H*6;
        if h==6 
            h=0;
        end
        hh=floor(h);           
        p1=V.*(1-S);
        p2=V.*(1-S.*(h-hh));
        p3=V.*(1-S.*(1-(h-hh)));

   if  hh==0 
        r=V; 
        g=p3; 
        b=p1;
   elseif hh==1 
        r=p2;
        g=V;
        b=p1;
   elseif hh==2
        r=p1;
        g=V;
        b=p3;
   elseif hh==3 
        r=p1;
        g=p2; 
        b=V;
   elseif hh==4 
        r=p3; 
        g=p1; 
        b=V;
   else               
        r=V; 
        g=p1; 
        b=p2; 
    end

    R=uint8(r*255);                
    G=uint8(g*255);
    B=uint8(b*255);
    Z=I;
    Z(:,:,1)=R;
    Z(:,:,2)=G;
    Z(:,:,3)=B;
    end
end