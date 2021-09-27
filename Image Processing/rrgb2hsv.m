function Z=rrgb2hsv();
%function I=rgb2hsv();
    I=imread('/Users/user/Desktop/resana1.jpg');
    R=I(:,:,1);
    G=I(:,:,2);
    B=I(:,:,3);
    H=double(R);
    S=double(R);
    V=double(R);
    r=double(R)./255;
    g=double(G)./255;
    b=double(B)./255;
    V=(r+g+b)/3;
    M=max(max(r,g),b);
    m=min(min(r,g),b);
    d=M-m;
    if d==0
        H=0;
        S=0;
    else
        S=d./M;
        dR =(M-r)./(6*d) +0.5;
        dG =(M-g)./(6*d) +0.5;
        dB =(M-b)./(6*d) +0.5;
       
        if r==M 
            H=dB-dG;
        elseif g==M
            H=(1/3)+dR-dB;
        elseif b==M
            H = (2/3)+dG-dR;
        end
    end
    Z=I;
    Z(:,:,1)=H;
    Z(:,:,2)=S;
    Z(:,:,3)=V;
end