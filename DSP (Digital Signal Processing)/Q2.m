function Q2();
    I=imread('/Users/user/Downloads/HW2/Q2/qqq.jpg');
    I=I(:,:,1);
    %n=sum(sum(I==255));
    x=size(I(:,1),1);
    y=size(I(1,:),2);
    dia=sqrt(x^2+y^2);
    
    tta=-pi:0.01:pi;
    R=0:1:dia;
    H=zeros( (2*size(R,2)+1) , (size(tta,2))  );
    tta2=floor((pi+tta)*100+1);
    for i=1:x
        for j=1:y
            if (I(i,j)==255)
                r1=double(i*cos(tta)+j*sin(tta));
                r2=floor(r1+dia+1);
                for k=1:size(tta,2)
                    H(r2(k),k)=H(r2(k),k)+1;
                end
            end
        end
    end
    %imagesc(H)
    %subplot(1,2,1); imagesc(H);
    %H(1:size(R,2),:)=0;
    %H((size(R,2)+1):(2*size(R,2)+1),:)=0;
    %m=max(max(H));
    %m=255/m;
    %H=uint8(m*H);
    HH=H;
    m=max(max(H));
    HH=(H>(0.4*m));
    %HH=255*HH;
    %HH=uint8(HH);
    HH=H.*HH;
    %imagesc(HH)
    %subplot(1,2,2); imagesc(HH);
    %imshow(test3(x,y,HH));
    imshow((double(I)+test3(x,y,HH))/2); saveas(gca,'/Users/user/Downloads/HW2/Q2/Q2.jpg','jpg');
end