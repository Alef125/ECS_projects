function HW5_Q1()
    %%%%%%%%%%%%%PIC1   %%%%%%%%%%%
    I1=imread('/Users/user/Desktop/HW5/Backgraund_Desert.jpg');
    x1=size(I1,1);
    y1=size(I1,2);
    %imshow(I1);
    I2=imread('/Users/user/Desktop/HW5/Snake.png');
    x2=size(I2,1);
    y2=size(I2,2);
    %200 700 500 1100
    I=I1.*0;
    %starting point
    x0=800;
    y0=200;
    I(x0+1:x0+x2,y0+1:y0+y2,:)=I2;
    %imshow(I);
    II=zeros(x1,y1);
    th=7;
    for i=1:x1
        for j=1:y1
            if ((I(i,j,1)<th) && (I(i,j,2)<th) && (I(i,j,3)<th))
                II(i,j)=1;
            end
        end
    end
    %II=(I(:,:,1)+I(:,:,2)+I(:,:,3))/3;
    %II(II<1)=0;
    %II(II~=0)=1;
    II=1-II;
    %imshow(II);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    ng = 50;
    x = -ng:ng;
    y = -ng:ng;
    o = ones(1,2*ng+1);
    X = o' * x;
    Y = y' * o;
    D = sqrt(X .^2 + Y .^2);
    sigma = 15;
    G = (1/sqrt(2*pi*sigma^2))*(exp(-(D.^2)/(2*sigma*sigma))) ;
    %%%%%%%%%%%%%%%%%
    III=conv2(double(II),double(G));
    J=III(ng+1:ng+x1,ng+1:ng+y1);
    mask=zeros(x1,y1,3);
    J=J/max(max(J));
    mask(:,:,1)=J;
    mask(:,:,2)=J;
    mask(:,:,3)=J;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    If=zeros(x1,y1,3);
    If=double(I1).*(double(ones(x1,y1,3))-double(mask))+double(I).*double(mask);
    If=uint8(If);
    imshow(If);
    saveas(gcf,'/Users/user/Desktop/HW5/im01.jpg','jpg');
    
    
    %%%%%%%%%%%%PIC2  %%%%%%%%%%%%%%
    I1=imread('/Users/user/Desktop/HW5/Earth.jpg');
    x1=size(I1,1);
    y1=size(I1,2);
    %imshow(I1);
    I2=imread('/Users/user/Desktop/HW5/Meteorite.png');
    x2=size(I2,1);
    y2=size(I2,2);
    %160 830
    I=I1.*0;
    %starting point
    x0=160;
    y0=730;
    I(x0+1:x0+x2,y0+1:y0+y2,:)=I2;
    %imshow(I);
    II=zeros(x1,y1);
    th=7;
    for i=1:x1
        for j=1:y1
            if ((I(i,j,1)<th) && (I(i,j,2)<th) && (I(i,j,3)<th))
                II(i,j)=1;
            end
        end
    end
    %II=(I(:,:,1)+I(:,:,2)+I(:,:,3))/3;
    %II(II<1)=0;
    %II(II~=0)=1;
    II=1-II;
    %imshow(II);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    ng = 50;
    x = -ng:ng;
    y = -ng:ng;
    o = ones(1,2*ng+1);
    X = o' * x;
    Y = y' * o;
    D = sqrt(X .^2 + Y .^2);
    sigma = 15;
    G = (1/sqrt(2*pi*sigma^2))*(exp(-(D.^2)/(2*sigma*sigma))) ;
    %%%%%%%%%%%%%%%%%
    III=conv2(double(II),double(G));
    J=III(ng+1:ng+x1,ng+1:ng+y1);
    mask=zeros(x1,y1,3);
    J=J/max(max(J));
    mask(:,:,1)=J;
    mask(:,:,2)=J;
    mask(:,:,3)=J;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    If=zeros(x1,y1,3);
    If=double(I1).*(double(ones(x1,y1,3))-double(mask))+double(I).*double(mask);
    If=uint8(If);
    imshow(If);
    saveas(gcf,'/Users/user/Desktop/HW5/im02.jpg','jpg');
end