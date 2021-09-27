function JJJ=test7(I,J);
    %%%%%%%%%%%%%%%%%%%
    %I=imread('/Users/user/Desktop/HW3/dog.jpg');
    II=I;
    x=size(I,2);
    y=size(I,1);
    %%%%%%%%%%%%%%%%%%%
    %JJ(:,:,1)=J;
    %JJ(:,:,2)=J;
    %JJ(:,:,3)=J;
    %%%%%%%%%%%%%%%%%%%
    JJ=zeros(y,x);
    n=25;
    K=J([n+1:y-n],[n+1:x-n]);
    for i=-n:n
        for j=-n:n
            JJ([n+1+i:y-n+i],[n+1+j:x-n+j])=JJ([n+1+i:y-n+i],[n+1+j:x-n+j])+K;
        end
    end
    lim1=50;
    JJ(JJ==(2*n+1)^2)=0;
    JJ(JJ>lim1)=255;
    JJ=JJ.*J;
    JJ=uint8(JJ);
    %%%%%%%%%%%%%%%%%%%
    
    %%%%%%%%%%%%%%%%%%%
    Temp=zeros(2*n+1,2*n+1,3);
    for i=n+1:n:y-n
        for j=n+1:n:x-n
            if (JJ(i,j)==255)
                Temp=test8(II,i,j);
                II([i-n:i+n],[j-n:j+n],:)=Temp;
            end
        end
    end
    %%%%%%%%%%%%%%%%%%%
    %imshow(II);
    %saveas(gcf,'/Users/user/Desktop/HW3/14_hybrid.jpg','jpg');
    %%%%%%%%%%%%%%%%%%%
    JF=J;
    JF(II(:,:,1)==0)=1;
    JF(II(:,:,2)==0)=1;
    JF(II(:,:,3)==0)=1;
    %s=sum(sum(JF));
    %if (sum(sum(J)) > 0)
    %for o=1:1
    %    III=test7(II);
    %end
    JJJ=zeros(y,x,4);
    JJJ(:,:,1)=JF;
    JJJ(:,:,2)=II(:,:,1);
    JJJ(:,:,3)=II(:,:,2);
    JJJ(:,:,4)=II(:,:,3);
    %%%%%%%%%%%%%%%%%%%
end