function J=gradient(I,n,sigma);
    J01=hor_row(I,n,sigma);
    J02=ver_row(I,n,sigma);
    
    J1=hor_col(J01,n,sigma);
    J2=ver_col(J02,n,sigma);
    
    %Combining 3 Color layers
    JJ1=sqrt(   J1(:,:,1).*J1(:,:,1)   +   J1(:,:,2).*J1(:,:,2)   +   J1(:,:,3).*J1(:,:,3)   );
    JJ2=sqrt(   J2(:,:,1).*J2(:,:,1)   +   J2(:,:,2).*J2(:,:,2)   +   J2(:,:,3).*J2(:,:,3)   );
    
    %Gradient
    J0=sqrt((JJ1.*JJ1)+(JJ2.*JJ2));
    m=max(max(J0));
    m=255/m;
    J=uint8(m*J0);
    
end