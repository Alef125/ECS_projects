function kk=test9(G1,G2,n);
    G3=G1*0;
    G3(G1==0)=1.00;
    G1=G1+G2.*G3;
    GG=(G1-G2).*(G1-G2);
    sigma=5;
    GGG=zeros(2*n+1,2*n+1,3);
    X=[-n:n];
    Y=[-n:n];
    Gx=(exp(-(X.*X)/(2*sigma^2)));
    Gy=(exp(-(Y.*Y)/(2*sigma^2)));
    G=Gy'*Gx;
    G=G/(sum(sum(G)));
    
    
    GGG(:,:,1)=double(GG(:,:,1)).*G;
    GGG(:,:,2)=double(GG(:,:,2)).*G;
    GGG(:,:,3)=double(GG(:,:,3)).*G;
    k=sum(sum(GGG));
    kk=(k(1)+k(2)+k(3))/3;
end