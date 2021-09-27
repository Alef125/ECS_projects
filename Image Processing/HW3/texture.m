function F=texture();
    I=imread('/Users/user/Desktop/HW3/dog.jpg');
    %%%%%%%%%%%%%%%%%%%%%%%
    x=size(I,2);
    y=size(I,1);
    J=zeros(y,x);
    J(I(:,:,1)==0)=1;
    J(I(:,:,2)==0)=1;
    J(I(:,:,3)==0)=1;
    imagesc(J);
    saveas(gcf,cat(2,'/Users/user/Desktop/HW3/16_mask.jpg'),'jpg');
    %%%%%%%%%%%%%%%%%%%%%%
    I1=I;
    s=sum(sum(J));
    F=zeros(y,x,3);
    JF=J;
    while (s>100)
     JJJ=test7(I1,J);
     JF=JJJ(:,:,1);
     F=JJJ(:,:,2:4);
     s=sum(sum(JF));
     I1=F;
     imshow(F);
     saveas(gcf,cat(2,'/Users/user/Desktop/HW3/Layer',num2str(s),'.jpg'),'jpg');
    end
    imshow(F);
     saveas(gcf,cat(2,'/Users/user/Desktop/HW3/16_impained'.jpg'),'jpg');
end