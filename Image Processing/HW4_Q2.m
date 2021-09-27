function HW4_Q2()
    I=imread('/Users/user/Desktop/HW4/im053.jpg');
    %%%%%%%%%%%%%%%%%%% Filters %%%%%%%%%%%%%%%%%%
    %Filter Bank
    n = 30;
    x = -n:n;
    y = -n:n;
    o = ones(1,2*n+1);
    X = o' * x;
    Y = y' * o;
    F=zeros(2*n+1,2*n+1,36);
    %%%%%%%%%%%%%%%%%%% Filter 1 %%%%%%%%%%%%%%%%%
    tta = 0;
    c = cos(tta);
    s = sin(tta);
    D1 = ( (s*X) + (c*Y) );
    D2 = abs( (c*X) - (s*Y) );
    sigma1 = 7;
    sigma2 = 10;
    G1 = D1.*( (1/sqrt(2*pi*sigma1^6))*(exp(-(D1.^2)/(2*sigma1*sigma1))) );
    G2 = (1/sqrt(2*pi*sigma2^2))*(exp(-(D2.^2)/(2*sigma2*sigma2)));
    F(:,:,1) = G1.*G2;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%% Filter 2 %%%%%%%%%%%%%%%%%
    tta = pi/6;
    c = cos(tta);
    s = sin(tta);
    D1 = ( (s*X) + (c*Y) );
    D2 = abs( (c*X) - (s*Y) );
    sigma1 = 7;
    sigma2 = 10;
    G1 = D1.*( (1/sqrt(2*pi*sigma1^6))*(exp(-(D1.^2)/(2*sigma1*sigma1))) );
    G2 = (1/sqrt(2*pi*sigma2^2))*(exp(-(D2.^2)/(2*sigma2*sigma2)));
    F(:,:,2) = G1.*G2;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%% Filter 3 %%%%%%%%%%%%%%%%%
    tta = pi/3;
    c = cos(tta);
    s = sin(tta);
    D1 = ( (s*X) + (c*Y) );
    D2 = abs( (c*X) - (s*Y) );
    sigma1 = 7;
    sigma2 = 10;
    G1 = D1.*( (1/sqrt(2*pi*sigma1^6))*(exp(-(D1.^2)/(2*sigma1*sigma1))) );
    G2 = (1/sqrt(2*pi*sigma2^2))*(exp(-(D2.^2)/(2*sigma2*sigma2)));
    F(:,:,3) = G1.*G2;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%% Filter 4 %%%%%%%%%%%%%%%%%
    tta = pi/2;
    c = cos(tta);
    s = sin(tta);
    D1 = ( (s*X) + (c*Y) );
    D2 = abs( (c*X) - (s*Y) );
    sigma1 = 7;
    sigma2 = 10;
    G1 = D1.*( (1/sqrt(2*pi*sigma1^6))*(exp(-(D1.^2)/(2*sigma1*sigma1))) );
    G2 = (1/sqrt(2*pi*sigma2^2))*(exp(-(D2.^2)/(2*sigma2*sigma2)));
    F(:,:,4) = G1.*G2;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%% Filter 5 %%%%%%%%%%%%%%%%%
    tta = 2*pi/3;
    c = cos(tta);
    s = sin(tta);
    D1 = ( (s*X) + (c*Y) );
    D2 = abs( (c*X) - (s*Y) );
    sigma1 = 7;
    sigma2 = 10;
    G1 = D1.*( (1/sqrt(2*pi*sigma1^6))*(exp(-(D1.^2)/(2*sigma1*sigma1))) );
    G2 = (1/sqrt(2*pi*sigma2^2))*(exp(-(D2.^2)/(2*sigma2*sigma2)));
    F(:,:,5) = G1.*G2;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%% Filter 6 %%%%%%%%%%%%%%%%%
    tta = 5*pi/6;
    c = cos(tta);
    s = sin(tta);
    D1 = ( (s*X) + (c*Y) );
    D2 = abs( (c*X) - (s*Y) );
    sigma1 = 7;
    sigma2 = 10;
    G1 = D1.*( (1/sqrt(2*pi*sigma1^6))*(exp(-(D1.^2)/(2*sigma1*sigma1))) );
    G2 = (1/sqrt(2*pi*sigma2^2))*(exp(-(D2.^2)/(2*sigma2*sigma2)));
    F(:,:,6) = G1.*G2;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%% Filter 7 %%%%%%%%%%%%%%%%%
    tta = 0;
    c = cos(tta);
    s = sin(tta);
    D1 = ( (s*X) + (c*Y) );
    D2 = abs( (c*X) - (s*Y) );
    sigma1 = 5;
    sigma2 = 7;
    G1 = D1.*( (1/sqrt(2*pi*sigma1^6))*(exp(-(D1.^2)/(2*sigma1*sigma1))) );
    G2 = (1/sqrt(2*pi*sigma2^2))*(exp(-(D2.^2)/(2*sigma2*sigma2)));
    F(:,:,7) = G1.*G2;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%% Filter 8 %%%%%%%%%%%%%%%%%
    tta = pi/6;
    c = cos(tta);
    s = sin(tta);
    D1 = ( (s*X) + (c*Y) );
    D2 = abs( (c*X) - (s*Y) );
    sigma1 = 5;
    sigma2 = 7;
    G1 = D1.*( (1/sqrt(2*pi*sigma1^6))*(exp(-(D1.^2)/(2*sigma1*sigma1))) );
    G2 = (1/sqrt(2*pi*sigma2^2))*(exp(-(D2.^2)/(2*sigma2*sigma2)));
    F(:,:,8) = G1.*G2;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%% Filter 9 %%%%%%%%%%%%%%%%%
    tta = pi/3;
    c = cos(tta);
    s = sin(tta);
    D1 = ( (s*X) + (c*Y) );
    D2 = abs( (c*X) - (s*Y) );
    sigma1 = 5;
    sigma2 = 7;
    G1 = D1.*( (1/sqrt(2*pi*sigma1^6))*(exp(-(D1.^2)/(2*sigma1*sigma1))) );
    G2 = (1/sqrt(2*pi*sigma2^2))*(exp(-(D2.^2)/(2*sigma2*sigma2)));
    F(:,:,9) = G1.*G2;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%% Filter 10 %%%%%%%%%%%%%%%%
    tta = pi/2;
    c = cos(tta);
    s = sin(tta);
    D1 = ( (s*X) + (c*Y) );
    D2 = abs( (c*X) - (s*Y) );
    sigma1 = 5;
    sigma2 = 7;
    G1 = D1.*( (1/sqrt(2*pi*sigma1^6))*(exp(-(D1.^2)/(2*sigma1*sigma1))) );
    G2 = (1/sqrt(2*pi*sigma2^2))*(exp(-(D2.^2)/(2*sigma2*sigma2)));
    F(:,:,10) = G1.*G2;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%% Filter 11 %%%%%%%%%%%%%%%%
    tta = 2*pi/3;
    c = cos(tta);
    s = sin(tta);
    D1 = ( (s*X) + (c*Y) );
    D2 = abs( (c*X) - (s*Y) );
    sigma1 = 5;
    sigma2 = 7;
    G1 = D1.*( (1/sqrt(2*pi*sigma1^6))*(exp(-(D1.^2)/(2*sigma1*sigma1))) );
    G2 = (1/sqrt(2*pi*sigma2^2))*(exp(-(D2.^2)/(2*sigma2*sigma2)));
    F(:,:,11) = G1.*G2;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%% Filter 12 %%%%%%%%%%%%%%%%
    tta = 5*pi/6;
    c = cos(tta);
    s = sin(tta);
    D1 = ( (s*X) + (c*Y) );
    D2 = abs( (c*X) - (s*Y) );
    sigma1 = 5;
    sigma2 = 7;
    G1 = D1.*( (1/sqrt(2*pi*sigma1^6))*(exp(-(D1.^2)/(2*sigma1*sigma1))) );
    G2 = (1/sqrt(2*pi*sigma2^2))*(exp(-(D2.^2)/(2*sigma2*sigma2)));
    F(:,:,12) = G1.*G2;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%% Filter 13 %%%%%%%%%%%%%%%%
    tta = 0;
    c = cos(tta);
    s = sin(tta);
    D1 = ( (s*X) + (c*Y) );
    D2 = abs( (c*X) - (s*Y) );
    sigma1 = 3;
    sigma2 = 5;
    G1 = D1.*( (1/sqrt(2*pi*sigma1^6))*(exp(-(D1.^2)/(2*sigma1*sigma1))) );
    G2 = (1/sqrt(2*pi*sigma2^2))*(exp(-(D2.^2)/(2*sigma2*sigma2)));
    F(:,:,13) = G1.*G2;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
    %%%%%%%%%%%%%%%%%%% Filter 14 %%%%%%%%%%%%%%%%
    tta = pi/6;
    c = cos(tta);
    s = sin(tta);
    D1 = ( (s*X) + (c*Y) );
    D2 = abs( (c*X) - (s*Y) );
    sigma1 = 3;
    sigma2 = 5;
    G1 = D1.*( (1/sqrt(2*pi*sigma1^6))*(exp(-(D1.^2)/(2*sigma1*sigma1))) );
    G2 = (1/sqrt(2*pi*sigma2^2))*(exp(-(D2.^2)/(2*sigma2*sigma2)));
    F(:,:,14) = G1.*G2;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%% Filter 15 %%%%%%%%%%%%%%%%
    tta = pi/3;
    c = cos(tta);
    s = sin(tta);
    D1 = ( (s*X) + (c*Y) );
    D2 = abs( (c*X) - (s*Y) );
    sigma1 = 3;
    sigma2 = 5;
    G1 = D1.*( (1/sqrt(2*pi*sigma1^6))*(exp(-(D1.^2)/(2*sigma1*sigma1))) );
    G2 = (1/sqrt(2*pi*sigma2^2))*(exp(-(D2.^2)/(2*sigma2*sigma2)));
    F(:,:,15) = G1.*G2;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%% Filter 16 %%%%%%%%%%%%%%%%
    tta = pi/2;
    c = cos(tta);
    s = sin(tta);
    D1 = ( (s*X) + (c*Y) );
    D2 = abs( (c*X) - (s*Y) );
    sigma1 = 3;
    sigma2 = 5;
    G1 = D1.*( (1/sqrt(2*pi*sigma1^6))*(exp(-(D1.^2)/(2*sigma1*sigma1))) );
    G2 = (1/sqrt(2*pi*sigma2^2))*(exp(-(D2.^2)/(2*sigma2*sigma2)));
    F(:,:,16) = G1.*G2;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%% Filter 17 %%%%%%%%%%%%%%%%
    tta = 2*pi/3;
    c = cos(tta);
    s = sin(tta);
    D1 = abs( (s*X) + (c*Y) );
    D2 = abs( (c*X) - (s*Y) );
    sigma1 = 3;
    sigma2 = 5;
    G1 = D1.*( (1/sqrt(2*pi*sigma1^6))*(exp(-(D1.^2)/(2*sigma1*sigma1))) );
    G2 = (1/sqrt(2*pi*sigma2^2))*(exp(-(D2.^2)/(2*sigma2*sigma2)));
    F(:,:,17) = G1.*G2;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%% Filter 18 %%%%%%%%%%%%%%%%
    tta = 5*pi/6;
    c = cos(tta);
    s = sin(tta);
    D1 = abs( (s*X) + (c*Y) );
    D2 = abs( (c*X) - (s*Y) );
    sigma1 = 3;
    sigma2 = 5;
    G1 = D1.*( (1/sqrt(2*pi*sigma1^6))*(exp(-(D1.^2)/(2*sigma1*sigma1))) );
    G2 = (1/sqrt(2*pi*sigma2^2))*(exp(-(D2.^2)/(2*sigma2*sigma2)));
    F(:,:,18) = G1.*G2;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%% Filter 19 %%%%%%%%%%%%%%%%%
    tta = 0;
    c = cos(tta);
    s = sin(tta);
    D1 = abs( (s*X) + (c*Y) );
    D2 = abs( (c*X) - (s*Y) );
    sigma1 = 7;
    sigma2 = 10;
    G1 = (D1.^2-sigma1^2).*( (1/sqrt(2*pi*sigma1^10))*(exp(-(D1.^2)/(2*sigma1*sigma1))) );
    G2 = (1/sqrt(2*pi*sigma2^2))*(exp(-(D2.^2)/(2*sigma2*sigma2)));
    F(:,:,19) = G1.*G2;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%% Filter 20 %%%%%%%%%%%%%%%%%
    tta = pi/6;
    c = cos(tta);
    s = sin(tta);
    D1 = abs( (s*X) + (c*Y) );
    D2 = abs( (c*X) - (s*Y) );
    sigma1 = 7;
    sigma2 = 10;
    G1 = (D1.^2-sigma1^2).*( (1/sqrt(2*pi*sigma1^10))*(exp(-(D1.^2)/(2*sigma1*sigma1))) );
    G2 = (1/sqrt(2*pi*sigma2^2))*(exp(-(D2.^2)/(2*sigma2*sigma2)));
    F(:,:,20) = G1.*G2;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%% Filter 21 %%%%%%%%%%%%%%%%%
    tta = pi/3;
    c = cos(tta);
    s = sin(tta);
    D1 = abs( (s*X) + (c*Y) );
    D2 = abs( (c*X) - (s*Y) );
    sigma1 = 7;
    sigma2 = 10;
    G1 = (D1.^2-sigma1^2).*( (1/sqrt(2*pi*sigma1^10))*(exp(-(D1.^2)/(2*sigma1*sigma1))) );
    G2 = (1/sqrt(2*pi*sigma2^2))*(exp(-(D2.^2)/(2*sigma2*sigma2)));
    F(:,:,21) = G1.*G2;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%% Filter 22 %%%%%%%%%%%%%%%%%
    tta = pi/2;
    c = cos(tta);
    s = sin(tta);
    D1 = abs( (s*X) + (c*Y) );
    D2 = abs( (c*X) - (s*Y) );
    sigma1 = 7;
    sigma2 = 10;
    G1 = (D1.^2-sigma1^2).*( (1/sqrt(2*pi*sigma1^10))*(exp(-(D1.^2)/(2*sigma1*sigma1))) );
    G2 = (1/sqrt(2*pi*sigma2^2))*(exp(-(D2.^2)/(2*sigma2*sigma2)));
    F(:,:,22) = G1.*G2;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%% Filter 23 %%%%%%%%%%%%%%%%%
    tta = 2*pi/3;
    c = cos(tta);
    s = sin(tta);
    D1 = abs( (s*X) + (c*Y) );
    D2 = abs( (c*X) - (s*Y) );
    sigma1 = 7;
    sigma2 = 10;
    G1 = (D1.^2-sigma1^2).*( (1/sqrt(2*pi*sigma1^10))*(exp(-(D1.^2)/(2*sigma1*sigma1))) );
    G2 = (1/sqrt(2*pi*sigma2^2))*(exp(-(D2.^2)/(2*sigma2*sigma2)));
    F(:,:,23) = G1.*G2;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%% Filter 24 %%%%%%%%%%%%%%%%%
    tta = 5*pi/6;
    c = cos(tta);
    s = sin(tta);
    D1 = abs( (s*X) + (c*Y) );
    D2 = abs( (c*X) - (s*Y) );
    sigma1 = 7;
    sigma2 = 10;
    G1 = (D1.^2-sigma1^2).*( (1/sqrt(2*pi*sigma1^10))*(exp(-(D1.^2)/(2*sigma1*sigma1))) );
    G2 = (1/sqrt(2*pi*sigma2^2))*(exp(-(D2.^2)/(2*sigma2*sigma2)));
    F(:,:,24) = G1.*G2;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%% Filter 25 %%%%%%%%%%%%%%%%%
    tta = 0;
    c = cos(tta);
    s = sin(tta);
    D1 = abs( (s*X) + (c*Y) );
    D2 = abs( (c*X) - (s*Y) );
    sigma1 = 5;
    sigma2 = 7;
    G1 = (D1.^2-sigma1^2).*( (1/sqrt(2*pi*sigma1^10))*(exp(-(D1.^2)/(2*sigma1*sigma1))) );
    G2 = (1/sqrt(2*pi*sigma2^2))*(exp(-(D2.^2)/(2*sigma2*sigma2)));
    F(:,:,25) = G1.*G2;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%% Filter 26 %%%%%%%%%%%%%%%%%
    tta = pi/6;
    c = cos(tta);
    s = sin(tta);
    D1 = abs( (s*X) + (c*Y) );
    D2 = abs( (c*X) - (s*Y) );
    sigma1 = 5;
    sigma2 = 7;
    G1 = (D1.^2-sigma1^2).*( (1/sqrt(2*pi*sigma1^10))*(exp(-(D1.^2)/(2*sigma1*sigma1))) );
    G2 = (1/sqrt(2*pi*sigma2^2))*(exp(-(D2.^2)/(2*sigma2*sigma2)));
    F(:,:,26) = G1.*G2;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%% Filter 27 %%%%%%%%%%%%%%%%%
    tta = pi/3;
    c = cos(tta);
    s = sin(tta);
    D1 = abs( (s*X) + (c*Y) );
    D2 = abs( (c*X) - (s*Y) );
    sigma1 = 5;
    sigma2 = 7;
    G1 = (D1.^2-sigma1^2).*( (1/sqrt(2*pi*sigma1^10))*(exp(-(D1.^2)/(2*sigma1*sigma1))) );
    G2 = (1/sqrt(2*pi*sigma2^2))*(exp(-(D2.^2)/(2*sigma2*sigma2)));
    F(:,:,27) = G1.*G2;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%% Filter 28 %%%%%%%%%%%%%%%%
    tta = pi/2;
    c = cos(tta);
    s = sin(tta);
    D1 = abs( (s*X) + (c*Y) );
    D2 = abs( (c*X) - (s*Y) );
    sigma1 = 5;
    sigma2 = 7;
    G1 = (D1.^2-sigma1^2).*( (1/sqrt(2*pi*sigma1^10))*(exp(-(D1.^2)/(2*sigma1*sigma1))) );
    G2 = (1/sqrt(2*pi*sigma2^2))*(exp(-(D2.^2)/(2*sigma2*sigma2)));
    F(:,:,28) = G1.*G2;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%% Filter 29 %%%%%%%%%%%%%%%%
    tta = 2*pi/3;
    c = cos(tta);
    s = sin(tta);
    D1 = abs( (s*X) + (c*Y) );
    D2 = abs( (c*X) - (s*Y) );
    sigma1 = 5;
    sigma2 = 7;
    G1 = (D1.^2-sigma1^2).*( (1/sqrt(2*pi*sigma1^10))*(exp(-(D1.^2)/(2*sigma1*sigma1))) );
    G2 = (1/sqrt(2*pi*sigma2^2))*(exp(-(D2.^2)/(2*sigma2*sigma2)));
    F(:,:,29) = G1.*G2;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%% Filter 30 %%%%%%%%%%%%%%%%
    tta = 5*pi/6;
    c = cos(tta);
    s = sin(tta);
    D1 = abs( (s*X) + (c*Y) );
    D2 = abs( (c*X) - (s*Y) );
    sigma1 = 5;
    sigma2 = 7;
    G1 = (D1.^2-sigma1^2).*( (1/sqrt(2*pi*sigma1^10))*(exp(-(D1.^2)/(2*sigma1*sigma1))) );
    G2 = (1/sqrt(2*pi*sigma2^2))*(exp(-(D2.^2)/(2*sigma2*sigma2)));
    F(:,:,30) = G1.*G2;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%% Filter 31 %%%%%%%%%%%%%%%%
    tta = 0;
    c = cos(tta);
    s = sin(tta);
    D1 = abs( (s*X) + (c*Y) );
    D2 = abs( (c*X) - (s*Y) );
    sigma1 = 3;
    sigma2 = 5;
    G1 = (D1.^2-sigma1^2).*( (1/sqrt(2*pi*sigma1^10))*(exp(-(D1.^2)/(2*sigma1*sigma1))) );
    G2 = (1/sqrt(2*pi*sigma2^2))*(exp(-(D2.^2)/(2*sigma2*sigma2)));
    F(:,:,31) = G1.*G2;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
    %%%%%%%%%%%%%%%%%%% Filter 32 %%%%%%%%%%%%%%%%
    tta = pi/6;
    c = cos(tta);
    s = sin(tta);
    D1 = abs( (s*X) + (c*Y) );
    D2 = abs( (c*X) - (s*Y) );
    sigma1 = 3;
    sigma2 = 5;
    G1 = (D1.^2-sigma1^2).*( (1/sqrt(2*pi*sigma1^10))*(exp(-(D1.^2)/(2*sigma1*sigma1))) );
    G2 = (1/sqrt(2*pi*sigma2^2))*(exp(-(D2.^2)/(2*sigma2*sigma2)));
    F(:,:,32) = G1.*G2;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%% Filter 33 %%%%%%%%%%%%%%%%
    tta = pi/3;
    c = cos(tta);
    s = sin(tta);
    D1 = abs( (s*X) + (c*Y) );
    D2 = abs( (c*X) - (s*Y) );
    sigma1 = 3;
    sigma2 = 5;
    G1 = (D1.^2-sigma1^2).*( (1/sqrt(2*pi*sigma1^10))*(exp(-(D1.^2)/(2*sigma1*sigma1))) );
    G2 = (1/sqrt(2*pi*sigma2^2))*(exp(-(D2.^2)/(2*sigma2*sigma2)));
    F(:,:,33) = G1.*G2;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%% Filter 34 %%%%%%%%%%%%%%%%
    tta = pi/2;
    c = cos(tta);
    s = sin(tta);
    D1 = abs( (s*X) + (c*Y) );
    D2 = abs( (c*X) - (s*Y) );
    sigma1 = 3;
    sigma2 = 5;
    G1 = (D1.^2-sigma1^2).*( (1/sqrt(2*pi*sigma1^10))*(exp(-(D1.^2)/(2*sigma1*sigma1))) );
    G2 = (1/sqrt(2*pi*sigma2^2))*(exp(-(D2.^2)/(2*sigma2*sigma2)));
    F(:,:,34) = G1.*G2;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%% Filter 35 %%%%%%%%%%%%%%%%
    tta = 2*pi/3;
    c = cos(tta);
    s = sin(tta);
    D1 = abs( (s*X) + (c*Y) );
    D2 = abs( (c*X) - (s*Y) );
    sigma1 = 3;
    sigma2 = 5;
    G1 = (D1.^2-sigma1^2).*( (1/sqrt(2*pi*sigma1^10))*(exp(-(D1.^2)/(2*sigma1*sigma1))) );
    G2 = (1/sqrt(2*pi*sigma2^2))*(exp(-(D2.^2)/(2*sigma2*sigma2)));
    F(:,:,35) = G1.*G2;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%% Filter 36 %%%%%%%%%%%%%%%%
    tta = 5*pi/6;
    c = cos(tta);
    s = sin(tta);
    D1 = abs( (s*X) + (c*Y) );
    D2 = abs( (c*X) - (s*Y) );
    sigma1 = 3;
    sigma2 = 5;
    G1 = (D1.^2-sigma1^2).*( (1/sqrt(2*pi*sigma1^10))*(exp(-(D1.^2)/(2*sigma1*sigma1))) );
    G2 = (1/sqrt(2*pi*sigma2^2))*(exp(-(D2.^2)/(2*sigma2*sigma2)));
    F(:,:,36) = G1.*G2;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%% Filter 37 %%%%%%%%%%%%%%%%
    D = sqrt(X .^2 + Y .^2);
    sigma = 5;
    G = D.*( (1/sqrt(2*pi*sigma^6))*(exp(-(D.^2)/(2*sigma*sigma))) );
    F(:,:,37) = G;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%% Filter 38 %%%%%%%%%%%%%%%%
    D = sqrt(X .^2 + Y .^2);
    sigma = 5;
    G = (D.^2-sigma^2).*( (1/sqrt(2*pi*sigma^10))*(exp(-(D.^2)/(2*sigma*sigma))) );
    F(:,:,38) = G;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%% Filter 39 %%%%%%%%%%%%%%%%
    D = sqrt(X .^2 + Y .^2);
    sigma = 5;
    G = (1/sqrt(2*pi*sigma^2))*(exp(-(D.^2)/(2*sigma*sigma))) ;
    F(:,:,39) = G;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    R=zeros(2*n+size(I(:,:,1),1),2*n+size(I(:,:,1),2),36);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    R(:,:,1)=sqrt((conv2(double(I(:,:,1)),double(F(:,:,1)))).^2+(conv2(double(I(:,:,2)),double(F(:,:,1)))).^2+(conv2(double(I(:,:,3)),double(F(:,:,1)))).^2);
    R(:,:,2)=sqrt((conv2(double(I(:,:,1)),double(F(:,:,2)))).^2+(conv2(double(I(:,:,2)),double(F(:,:,2)))).^2+(conv2(double(I(:,:,3)),double(F(:,:,2)))).^2);
    R(:,:,3)=sqrt((conv2(double(I(:,:,1)),double(F(:,:,3)))).^2+(conv2(double(I(:,:,2)),double(F(:,:,3)))).^2+(conv2(double(I(:,:,3)),double(F(:,:,3)))).^2);
    R(:,:,4)=sqrt((conv2(double(I(:,:,1)),double(F(:,:,4)))).^2+(conv2(double(I(:,:,2)),double(F(:,:,4)))).^2+(conv2(double(I(:,:,3)),double(F(:,:,4)))).^2);
    R(:,:,5)=sqrt((conv2(double(I(:,:,1)),double(F(:,:,5)))).^2+(conv2(double(I(:,:,2)),double(F(:,:,5)))).^2+(conv2(double(I(:,:,3)),double(F(:,:,5)))).^2);
    R(:,:,6)=sqrt((conv2(double(I(:,:,1)),double(F(:,:,6)))).^2+(conv2(double(I(:,:,2)),double(F(:,:,6)))).^2+(conv2(double(I(:,:,3)),double(F(:,:,6)))).^2);
    R(:,:,7)=sqrt((conv2(double(I(:,:,1)),double(F(:,:,7)))).^2+(conv2(double(I(:,:,2)),double(F(:,:,7)))).^2+(conv2(double(I(:,:,3)),double(F(:,:,7)))).^2);
    R(:,:,8)=sqrt((conv2(double(I(:,:,1)),double(F(:,:,7)))).^2+(conv2(double(I(:,:,2)),double(F(:,:,8)))).^2+(conv2(double(I(:,:,3)),double(F(:,:,8)))).^2);
    R(:,:,9)=sqrt((conv2(double(I(:,:,1)),double(F(:,:,9)))).^2+(conv2(double(I(:,:,2)),double(F(:,:,9)))).^2+(conv2(double(I(:,:,3)),double(F(:,:,9)))).^2);
    R(:,:,10)=sqrt((conv2(double(I(:,:,1)),double(F(:,:,10)))).^2+(conv2(double(I(:,:,2)),double(F(:,:,10)))).^2+(conv2(double(I(:,:,3)),double(F(:,:,10)))).^2);
    R(:,:,11)=sqrt((conv2(double(I(:,:,1)),double(F(:,:,11)))).^2+(conv2(double(I(:,:,2)),double(F(:,:,11)))).^2+(conv2(double(I(:,:,3)),double(F(:,:,11)))).^2);
    R(:,:,12)=sqrt((conv2(double(I(:,:,1)),double(F(:,:,12)))).^2+(conv2(double(I(:,:,2)),double(F(:,:,12)))).^2+(conv2(double(I(:,:,3)),double(F(:,:,12)))).^2);
    R(:,:,13)=sqrt((conv2(double(I(:,:,1)),double(F(:,:,13)))).^2+(conv2(double(I(:,:,2)),double(F(:,:,13)))).^2+(conv2(double(I(:,:,3)),double(F(:,:,13)))).^2);
    R(:,:,14)=sqrt((conv2(double(I(:,:,1)),double(F(:,:,14)))).^2+(conv2(double(I(:,:,2)),double(F(:,:,14)))).^2+(conv2(double(I(:,:,3)),double(F(:,:,14)))).^2);
    R(:,:,15)=sqrt((conv2(double(I(:,:,1)),double(F(:,:,15)))).^2+(conv2(double(I(:,:,2)),double(F(:,:,15)))).^2+(conv2(double(I(:,:,3)),double(F(:,:,15)))).^2);
    R(:,:,16)=sqrt((conv2(double(I(:,:,1)),double(F(:,:,16)))).^2+(conv2(double(I(:,:,2)),double(F(:,:,16)))).^2+(conv2(double(I(:,:,3)),double(F(:,:,16)))).^2);
    R(:,:,17)=sqrt((conv2(double(I(:,:,1)),double(F(:,:,17)))).^2+(conv2(double(I(:,:,2)),double(F(:,:,17)))).^2+(conv2(double(I(:,:,3)),double(F(:,:,17)))).^2);
    R(:,:,18)=sqrt((conv2(double(I(:,:,1)),double(F(:,:,18)))).^2+(conv2(double(I(:,:,2)),double(F(:,:,18)))).^2+(conv2(double(I(:,:,3)),double(F(:,:,18)))).^2);
    R(:,:,19)=sqrt((conv2(double(I(:,:,1)),double(F(:,:,19)))).^2+(conv2(double(I(:,:,2)),double(F(:,:,19)))).^2+(conv2(double(I(:,:,3)),double(F(:,:,19)))).^2);
    R(:,:,20)=sqrt((conv2(double(I(:,:,1)),double(F(:,:,20)))).^2+(conv2(double(I(:,:,2)),double(F(:,:,20)))).^2+(conv2(double(I(:,:,3)),double(F(:,:,20)))).^2);
    R(:,:,21)=sqrt((conv2(double(I(:,:,1)),double(F(:,:,21)))).^2+(conv2(double(I(:,:,2)),double(F(:,:,21)))).^2+(conv2(double(I(:,:,3)),double(F(:,:,21)))).^2);
    R(:,:,22)=sqrt((conv2(double(I(:,:,1)),double(F(:,:,22)))).^2+(conv2(double(I(:,:,2)),double(F(:,:,22)))).^2+(conv2(double(I(:,:,3)),double(F(:,:,22)))).^2);
    R(:,:,23)=sqrt((conv2(double(I(:,:,1)),double(F(:,:,23)))).^2+(conv2(double(I(:,:,2)),double(F(:,:,23)))).^2+(conv2(double(I(:,:,3)),double(F(:,:,23)))).^2);
    R(:,:,24)=sqrt((conv2(double(I(:,:,1)),double(F(:,:,24)))).^2+(conv2(double(I(:,:,2)),double(F(:,:,24)))).^2+(conv2(double(I(:,:,3)),double(F(:,:,24)))).^2);
    R(:,:,25)=sqrt((conv2(double(I(:,:,1)),double(F(:,:,25)))).^2+(conv2(double(I(:,:,2)),double(F(:,:,25)))).^2+(conv2(double(I(:,:,3)),double(F(:,:,25)))).^2);
    R(:,:,26)=sqrt((conv2(double(I(:,:,1)),double(F(:,:,26)))).^2+(conv2(double(I(:,:,2)),double(F(:,:,26)))).^2+(conv2(double(I(:,:,3)),double(F(:,:,26)))).^2);
    R(:,:,27)=sqrt((conv2(double(I(:,:,1)),double(F(:,:,27)))).^2+(conv2(double(I(:,:,2)),double(F(:,:,27)))).^2+(conv2(double(I(:,:,3)),double(F(:,:,27)))).^2);
    R(:,:,28)=sqrt((conv2(double(I(:,:,1)),double(F(:,:,28)))).^2+(conv2(double(I(:,:,2)),double(F(:,:,28)))).^2+(conv2(double(I(:,:,3)),double(F(:,:,28)))).^2);
    R(:,:,29)=sqrt((conv2(double(I(:,:,1)),double(F(:,:,29)))).^2+(conv2(double(I(:,:,2)),double(F(:,:,29)))).^2+(conv2(double(I(:,:,3)),double(F(:,:,29)))).^2);
    R(:,:,30)=sqrt((conv2(double(I(:,:,1)),double(F(:,:,30)))).^2+(conv2(double(I(:,:,2)),double(F(:,:,30)))).^2+(conv2(double(I(:,:,3)),double(F(:,:,30)))).^2);
    R(:,:,31)=sqrt((conv2(double(I(:,:,1)),double(F(:,:,31)))).^2+(conv2(double(I(:,:,2)),double(F(:,:,31)))).^2+(conv2(double(I(:,:,3)),double(F(:,:,31)))).^2);
    R(:,:,32)=sqrt((conv2(double(I(:,:,1)),double(F(:,:,32)))).^2+(conv2(double(I(:,:,2)),double(F(:,:,32)))).^2+(conv2(double(I(:,:,3)),double(F(:,:,32)))).^2);
    R(:,:,33)=sqrt((conv2(double(I(:,:,1)),double(F(:,:,33)))).^2+(conv2(double(I(:,:,2)),double(F(:,:,33)))).^2+(conv2(double(I(:,:,3)),double(F(:,:,33)))).^2);
    R(:,:,34)=sqrt((conv2(double(I(:,:,1)),double(F(:,:,34)))).^2+(conv2(double(I(:,:,2)),double(F(:,:,34)))).^2+(conv2(double(I(:,:,3)),double(F(:,:,34)))).^2);
    R(:,:,35)=sqrt((conv2(double(I(:,:,1)),double(F(:,:,35)))).^2+(conv2(double(I(:,:,2)),double(F(:,:,35)))).^2+(conv2(double(I(:,:,3)),double(F(:,:,35)))).^2);
    R(:,:,36)=sqrt((conv2(double(I(:,:,1)),double(F(:,:,36)))).^2+(conv2(double(I(:,:,2)),double(F(:,:,36)))).^2+(conv2(double(I(:,:,3)),double(F(:,:,36)))).^2);
    R(:,:,37)=sqrt((conv2(double(I(:,:,1)),double(F(:,:,37)))).^2+(conv2(double(I(:,:,2)),double(F(:,:,37)))).^2+(conv2(double(I(:,:,3)),double(F(:,:,37)))).^2);
    R(:,:,38)=sqrt((conv2(double(I(:,:,1)),double(F(:,:,38)))).^2+(conv2(double(I(:,:,2)),double(F(:,:,38)))).^2+(conv2(double(I(:,:,3)),double(F(:,:,38)))).^2);
    R(:,:,39)=sqrt((conv2(double(I(:,:,1)),double(F(:,:,39)))).^2+(conv2(double(I(:,:,2)),double(F(:,:,39)))).^2+(conv2(double(I(:,:,3)),double(F(:,:,39)))).^2);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    Lambda=zeros(1,1,39);
    Lambda(1,1,:)=[1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 8 8 8];
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    mm=size(R(:,:,1),1)-n*4;
    nn=size(R(:,:,1),2)-n*4;
    l=mm*nn;
    RR=zeros(l,39);
    for i=(n*2+1):mm+(2*n)
        for j=(2*n+1):nn+(2*n)
            RR(nn*(i-(2*n+1))+(j-n*2),:)=R(i,j,:).*Lambda;
        end
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %subplot(1,2,1); imagesc(R(61:m+60,61:n+60,1));
    %subplot(1,2,2); imagesc(R(:,:,2));
    %subplot(6,6,3); imagesc(R(:,:,3));
    %subplot(6,6,4); imagesc(R(:,:,4));
    %subplot(6,6,5); imagesc(R(:,:,5));
    %subplot(6,6,6); imagesc(R(:,:,6));
    %subplot(6,6,7); imagesc(R(:,:,7));
    %subplot(6,6,8); imagesc(R(:,:,8));
    %subplot(6,6,9); imagesc(R(:,:,9));
    %subplot(6,6,10); imagesc(R(:,:,10));
    %subplot(6,6,11); imagesc(R(:,:,11));
    %subplot(6,6,12); imagesc(R(:,:,12));
    %subplot(6,6,13); imagesc(R(:,:,13));
    %subplot(6,6,14); imagesc(R(:,:,14));
    %subplot(6,6,15); imagesc(R(:,:,15));
    %subplot(6,6,16); imagesc(R(:,:,16));
    %subplot(6,6,17); imagesc(R(:,:,17));
    %subplot(6,6,18); imagesc(R(:,:,18));
    %subplot(6,6,19); imagesc(R(:,:,19));
    %subplot(6,6,20); imagesc(R(:,:,20));
    %subplot(6,6,21); imagesc(R(:,:,21));
    %subplot(6,6,22); imagesc(R(:,:,22));
    %subplot(6,6,23); imagesc(R(:,:,23));
    %subplot(6,6,24); imagesc(R(:,:,24));
    %subplot(6,6,25); imagesc(R(:,:,25));
    %subplot(6,6,26); imagesc(R(:,:,26));
    %subplot(6,6,27); imagesc(R(:,:,27));
    %subplot(6,6,28); imagesc(R(:,:,28));
    %subplot(6,6,29); imagesc(R(:,:,29));
    %subplot(6,6,30); imagesc(R(:,:,30));
    %subplot(6,6,31); imagesc(R(:,:,31));
    %subplot(6,6,32); imagesc(R(:,:,32));
    %subplot(6,6,33); imagesc(R(:,:,33));
    %subplot(6,6,34); imagesc(R(:,:,34));
    %subplot(6,6,35); imagesc(R(:,:,35));
    %subplot(6,6,36); imagesc(R(:,:,36));
    
    J=zeros(mm,nn);
    II=I(n+1:mm+n,n+1:nn+n,:);
    for ii=1:39
       IDX=kmeans(RR(:,ii),2);
    for i=1:mm
        for j=1:nn
            J(i,j)=IDX(nn*(i-1)+j);
        end
    end
    JJ(:,:,1)=J-1;
    JJ(:,:,2)=J-1;
    JJ(:,:,3)=J-1;
    III=uint8(double(II).*double(JJ));
           subplot(5,8,ii); imshow(III);
    end
    
    
    
    
    IDX=kmeans(RR,2);
    for i=1:mm
        for j=1:nn
            J(i,j)=IDX(nn*(i-1)+j);
        end
    end
    JJ(:,:,1)=J-1;
    JJ(:,:,2)=J-1;
    JJ(:,:,3)=J-1;
    III=uint8(double(II).*double(JJ));
    subplot(5,8,40); imshow(III);
    saveas(gcf,'/Users/user/Desktop/HW4/im04.jpg','jpg');
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end