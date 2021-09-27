function HW4_Q5()
    %SLIC
    I=imread('/Users/user/Desktop/HW4/im023.jpg');
    %imshow(I);
    II=rgb2lab(I);
    S=16;
    Lx=fix( size(I,1)/(S*2) );
    Ly=fix( size(I,2)/(S*2) );
    X=S:2*S:3304;
    Y=S:2*S:4408;
    C=zeros(Lx*Ly,5);
    for i=1:Lx
        for j=1:Ly
            C(Ly*(i-1)+j,:)=[II(X(i),Y(j),1) II(X(i),Y(j),2) II(X(i),Y(j),3) X(i) Y(j)];
        end
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    lambda=1;
    J=zeros(2*S*Lx,2*S*Ly);
    for i=1:Lx-1
        for j=1:Ly-2
            for kx=1:2*S-1
                for ky=1:2*S-1
                    dlab=sqrt( ( II( C(Ly*(i-1)+j,4)+kx , C(Ly*(i-1)+j,5)+ky , 1 ) - C(Ly*(i-1)+j,1) )^2 + ( II( C(Ly*(i-1)+j,4)+kx , C(Ly*(i-1)+j,5)+ky , 2 ) - C(Ly*(i-1)+j,2) )^2 + ( II( C(Ly*(i-1)+j,4)+kx , C(Ly*(i-1)+j,5)+ky , 3 ) - C(Ly*(i-1)+j,3) )^2 );
                    dxy =sqrt( kx^2 + ky^2 );
                    d1= dlab+lambda*dxy;
                    
                    dlab=sqrt( ( II( C(Ly*(i-1)+j,4)+kx , C(Ly*(i-1)+j,5)+ky , 1 ) - C(Ly*(i-1)+j+1,1) )^2 + ( II( C(Ly*(i-1)+j,4)+kx , C(Ly*(i-1)+j,5)+ky , 2 ) - C(Ly*(i-1)+j+1,2) )^2 + ( II( C(Ly*(i-1)+j,4)+kx , C(Ly*(i-1)+j,5)+ky , 3 ) - C(Ly*(i-1)+j+1,3) )^2 );
                    dxy =sqrt( kx^2 + (2*S-ky)^2 );
                    d2= dlab+lambda*dxy;
                    
                    dlab=sqrt( ( II( C(Ly*(i-1)+j,4)+kx , C(Ly*(i-1)+j,5)+ky , 1 ) - C(Ly*(i)+j,1) )^2 + ( II( C(Ly*(i-1)+j,4)+kx , C(Ly*(i-1)+j,5)+ky , 2 ) - C(Ly*(i)+j,2) )^2 + ( II( C(Ly*(i-1)+j,4)+kx , C(Ly*(i-1)+j,5)+ky , 3 ) - C(Ly*(i)+j,3) )^2 );
                    dxy =sqrt( (2*S-kx)^2 + ky^2 );
                    d3= dlab+lambda*dxy;
                    
                    dlab=sqrt( ( II( C(Ly*(i-1)+j,4)+kx , C(Ly*(i-1)+j,5)+ky , 1 ) - C(Ly*(i)+j+1,1) )^2 + ( II( C(Ly*(i-1)+j,4)+kx , C(Ly*(i-1)+j+1,5)+ky , 2 ) - C(Ly*(i)+j,2) )^2 + ( II( C(Ly*(i-1)+j,4)+kx , C(Ly*(i-1)+j,5)+ky , 3 ) - C(Ly*(i)+j+1,3) )^2 );
                    dxy =sqrt( (2*S-kx)^2 + (2*S-ky)^2 );
                    d4= dlab+lambda*dxy;
                    
                    d=max(d1,max(d2,max(d3,d4)));
                    J( S+(i-1)*S*2+kx , S+(j-1)*2*S+ky ) = (d==d1)*(Ly*(i-1)+j) + (d==d2)*(Ly*(i-1)+j+1) + (Ly*(i)+j) + (Ly*(i)+j+1);
                end
            end
        end
    end
    %imagesc(J);
    JJ=ones(2*S*Lx-1,2*S*Ly-1);
    JJ( ( J( 2:2*S*Lx , 1:2*S*Ly-1 )- J( 1:2*S*Lx-1 , 1:2*S*Ly-1) )==0 ) =0;
    JJ( ( J(1:2*S*Lx-1,2:2*S*Ly)-J(1:2*S*Lx-1,1:2*S*Ly-1) )==0 ) =0;
    %JJ=1-JJ;
    I(1:2*S*Lx-1,1:2*S*Ly-1,1)=double(I(1:2*S*Lx-1,1:2*S*Ly-1,1)).*double(JJ);
    I(1:2*S*Lx-1,1:2*S*Ly-1,2)=double(I(1:2*S*Lx-1,1:2*S*Ly-1,2)).*double(JJ);
    I(1:2*S*Lx-1,1:2*S*Ly-1,3)=double(I(1:2*S*Lx-1,1:2*S*Ly-1,3)).*double(JJ);
    imshow(I);
    %JJJ(:,:,1)=(J==100);
    %JJJ(:,:,2)=(J==100);
    %JJJ(:,:,3)=(J==100);
    %imshow(double(I(1:2*S*Lx-1,1:2*S*Ly-1,1)).*double(JJJ));
    saveas(gcf,'/Users/user/Desktop/HW4/im10.jpg','jpg');
end