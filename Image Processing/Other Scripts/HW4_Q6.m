function HW4_Q6()
    I=imread('/Users/user/Desktop/HW4/tasbih.jpg');
    imshow(I);
    N=36;
    k=1:N;
    Y=fix(550+350*cos((k/18)*pi));
    X=fix(400+350*sin((k/18)*pi));
    %I(X(1,:),Y(1,:),:)=0;
    %imshow(I);
    %scatter(X,Y,40,ones(1,36),'filled');
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    n = 30;
    x = -n:n;
    y = -n:n;
    o = ones(1,2*n+1);
    D2 = o' * x;
    D1 = y' * o;
    sigma1 = 7;
    sigma2 = 10;
    G1 = D1.*( (1/sqrt(2*pi*sigma1^6))*(exp(-(D1.^2)/(2*sigma1*sigma1))) );
    G2 = (1/sqrt(2*pi*sigma2^2))*(exp(-(D2.^2)/(2*sigma2*sigma2)));
    F = G1.*G2;
    R=sqrt((conv2(double(I(:,:,1)),double(F))).^2+(conv2(double(I(:,:,2)),double(F))).^2+(conv2(double(I(:,:,3)),double(F))).^2);
    R1=R(n+1:size(I,1)+n,n+1:size(I,2)+n);
    FF=F';
    R=sqrt((conv2(double(I(:,:,1)),double(FF))).^2+(conv2(double(I(:,:,2)),double(FF))).^2+(conv2(double(I(:,:,3)),double(FF))).^2);
    R2=R(n+1:size(I,1)+n,n+1:size(I,2)+n);
    %subplot(1,2,1); imagesc(R1); subplot(1,2,2); imagesc(R2);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    Eext=0;
    for k=1:N
        Eext=Eext-(R1(X(k),Y(k))^2 + R2(X(k),Y(k))^2);
    end
    Eela=((X(1)-X(36))^2+(Y(1)-Y(36))^2-d)^2;
    d=10;
    for k=1:N-1
        Eela=Eela+((X(k+1)-X(k))^2+(Y(k+1)-Y(k))^2-d)^2;
    end
    alpha=1;
    E=Eext+alpha*Eala;
end