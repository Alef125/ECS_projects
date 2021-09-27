function hybrid();
    I1=imread('/Users/user/Desktop/HW3/03_image1.jpg');
    I2=imread('/Users/user/Desktop/HW3/04_image2.jpg');
    %%%%%%%%%%%
    J0=fft2(I1);
    J1=fftshift(J0);
    J2=abs(J1);
    F1=log(J2);
    subplot (1,3,1); imagesc(F1(:,:,1));subplot (1,3,2); imagesc(F1(:,:,2));subplot (1,3,3); imagesc(F1(:,:,3));
    saveas(gcf,'/Users/user/Desktop/HW3/05_dft1.jpg','jpg');
    
    
    F1=J0;
    %%%%%%%%%%%%
    
    %%%%%%%%%%%
    J0=fft2(I2);
    J1=fftshift(J0);
    J2=abs(J1);
    F2=log(J2);
    subplot (1,3,1); imagesc(F2(:,:,1));subplot (1,3,2); imagesc(F2(:,:,2));subplot (1,3,3); imagesc(F2(:,:,3));
    saveas(gcf,'/Users/user/Desktop/HW3/06_dft2.jpg','jpg');
    
    
    F2=J0;
    %%%%%%%%%%%%
    
    %%%%%%%%%%%%
    x=size(F1,2);
    y=size(F1,1);
    r=60;
    
    X=[0:x-1];
    Y=[0:y-1];
    Gx=(exp(-((X-x/2).*(X-x/2))/(2*r*r)));
    Gy=(exp(-((Y-y/2).*(Y-y/2))/(2*r*r)));
    G=Gy'*Gx;
    G1(:,:,1)=G;
    G1(:,:,2)=G;
    G1(:,:,3)=G;
    subplot(1,1,1); imagesc(G);
    saveas(gcf,'/Users/user/Desktop/HW3/07_highpass_r.jpg','jpg');
    %%%%%%%%%%%%
    
    %%%%%%%%%%%%
    x=size(F2,2);
    y=size(F2,1);
    s=50;
    X=[0:x-1];
    Y=[0:y-1];
    Gx=(exp(-((X-x/2).*(X-x/2))/(2*s*s)));
    Gy=(exp(-((Y-y/2).*(Y-y/2))/(2*s*s)));
    G=ones(y,x);
    G=G-Gy'*Gx;
    G2(:,:,1)=G;
    G2(:,:,2)=G;
    G2(:,:,3)=G;
    subplot(1,1,1); imagesc(G); 
    saveas(gcf,'/Users/user/Desktop/HW3/08_lowpass_s.jpg','jpg');
    %%%%%%%%%%%%
    
    cutr=0.9;
    cuts=0.05;
    G1(G1<cutr)=0;
    G2(G2<cuts)=0;
    subplot(1,1,1); imagesc(G1(:,:,1));
    saveas(gcf,'/Users/user/Desktop/HW3/09_highpass_cutoff.r.jpg','jpg');
    subplot(1,1,1); imagesc(G2(:,:,1));
    saveas(gcf,'/Users/user/Desktop/HW3/10_lowpass_cutoff.s.jpg','jpg');
    %%%%%%%%%%%%
    J1=fftshift(F1);
    FF1=J1.*G1;
    J2=abs(FF1);
    FF11=log(J2);
    
    subplot (1,3,1); imagesc(FF11(:,:,1));subplot (1,3,2); imagesc(FF11(:,:,2));subplot (1,3,3); imagesc(FF11(:,:,3));
    saveas(gcf,'/Users/user/Desktop/HW3/11_highpassed.jpg','jpg');

    J1=fftshift(F2);
    FF2=J1.*G2;
    J2=abs(FF2);
    FF22=log(J2);
    subplot (1,3,1); imagesc(FF22(:,:,1));subplot (1,3,2); imagesc(FF22(:,:,2));subplot (1,3,3); imagesc(FF22(:,:,3));
    saveas(gcf,'/Users/user/Desktop/HW3/12_lowpassed.jpg','jpg');
    
    landa=1;
    FF=ifftshift(FF1)+landa*ifftshift(FF2);
    J1=fftshift(FF);
    J2=abs(J1);
    FF33=log(J2);
    subplot (1,3,1); imagesc(FF33(:,:,1));subplot (1,3,2); imagesc(FF33(:,:,2));subplot (1,3,3); imagesc(FF33(:,:,3));
    saveas(gcf,'/Users/user/Desktop/HW3/13_hybrid_frequency.jpg','jpg');
    
    
    II=ifft2(FF);
    m=max(max(max(II)));
    II=uint8(255*(II/m));
    subplot (1,1,1);imshow(II);
    saveas(gcf,'/Users/user/Desktop/HW3/14_hybrid.jpg','jpg');
    imshow(imresize(II,0.2));
    saveas(gcf,'/Users/user/Desktop/HW3/15_hybrid_far.jpg','jpg');
    %%%%%%%%%%%%
end