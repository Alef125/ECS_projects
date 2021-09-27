function ECT_Q1();
    %Coordination of Complex Plane
    sigma=[-10:0.1:10];
    omega=(i*[-10:0.1:10])';
    %Make the Complex plan, In surface
    onesVector=ones(10*2*10+1,1);
    surface= (onesVector*sigma) + ((-omega)*onesVector');
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %R=1, H(s)=s/(1+s+s2) 
    H=surface./(1+surface+surface.^2);
    %Magnitude of H(s)
    Hmagnitude=abs(H);
    %Phase of H(s)
    Hangle=atan(imag(H)./real(H));
    Hsign=sign(real(H));
    Hsigntest=(Hsign==-1);
    Hsign2=Hsigntest.*sign(imag(H));
    Hangle=Hangle+pi*Hsign2;
    %plotting Manitude and Phase
    subplot(1,2,1); surf(sigma,sigma,Hmagnitude); title('Magnitude of H(s)'); xlabel('Sigma'); ylabel('Omega');
    subplot(1,2,2); surf(sigma,sigma,Hangle); title('Phase of H(s)'); xlabel('Sigma'); ylabel('Omega');
    %Saving
    saveas(gcf,'/Users/user/Desktop/ECT/Q1/pic1.jpg','jpg');
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %R=5, H(s)=s/(5+s+5s2) 
    H=surface./(5+surface+5*surface.^2);
    %Magnitude of H(s)
    Hmagnitude=abs(H);
    %Phase of H(s)
    Hangle=atan(imag(H)./real(H));
    Hsign=sign(real(H));
    Hsigntest=(Hsign==-1);
    Hsign2=Hsigntest.*sign(imag(H));
    Hangle=Hangle+pi*Hsign2;
    %plotting Manitude and Phase
    subplot(1,2,1); surf(sigma,sigma,Hmagnitude); title('Magnitude of H(s)'); xlabel('Sigma'); ylabel('Omega');
    subplot(1,2,2); surf(sigma,sigma,Hangle); title('Phase of H(s)'); xlabel('Sigma'); ylabel('Omega');
    %Saving
    saveas(gcf,'/Users/user/Desktop/ECT/Q1/pic2.jpg','jpg');
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %R=20, H(s)=s/(20+s+20s2) 
    H=surface./(20+surface+20*surface.^2);
    %Magnitude of H(s)
    Hmagnitude=abs(H);
    %Phase of H(s)
    Hangle=atan(imag(H)./real(H));
    Hsign=sign(real(H));
    Hsigntest=(Hsign==-1);
    Hsign2=Hsigntest.*sign(imag(H));
    Hangle=Hangle+pi*Hsign2;
    %plotting Manitude and Phase
    subplot(1,2,1); surf(sigma,sigma,Hmagnitude); title('Magnitude of H(s)'); xlabel('Sigma'); ylabel('Omega');
    subplot(1,2,2); surf(sigma,sigma,Hangle); title('Phase of H(s)'); xlabel('Sigma'); ylabel('Omega');
    %Saving
    saveas(gcf,'/Users/user/Desktop/ECT/Q1/pic3.jpg','jpg');
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %R=1, H(s)=s/(1+s+s2) 
    H=surface./(1+surface+surface.^2);
    HZero=(H==0);
    HPol=(H>7);
    PolZero=HZero*1+HPol*-1;
    subplot(1,1,1); imagesc(PolZero); title('Poles and Zeros of H(s)'); xlabel('Sigma'); ylabel('Omega');
    saveas(gcf,'/Users/user/Desktop/ECT/Q1/pic4.jpg','jpg');
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %Delta Response
    X=[-50:0.1:50];
    syms s t;
    %R=1
    F=ilaplace(s/(1+s+s^2));
    f=symfun(F,t);
    plot(X,f(X));
    saveas(gcf,'/Users/user/Desktop/ECT/Q1/pic5.jpg','jpg');
    %R=5
    F=ilaplace(s/(5+s+5*s^2));
    f=symfun(F,t);
    plot(X,f(X));
    saveas(gcf,'/Users/user/Desktop/ECT/Q1/pic6.jpg','jpg');
    %R=20
    F=ilaplace(s/(20+s+20*s^2));
    f=symfun(F,t);
    plot(X,f(X));
    saveas(gcf,'/Users/user/Desktop/ECT/Q1/pic7.jpg','jpg');
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %U Response
    syms s t;
    %R=1
    F=ilaplace(1/(1+s+s^2));
    f=symfun(F,t);
    plot(X,f(X));
    saveas(gcf,'/Users/user/Desktop/ECT/Q1/pic8.jpg','jpg');
    %R=5
    F=ilaplace(1/(5+s+5*s^2));
    f=symfun(F,t);
    plot(X,f(X));
    saveas(gcf,'/Users/user/Desktop/ECT/Q1/pic9.jpg','jpg');
    %R=20
    F=ilaplace(1/(20+s+20*s^2));
    f=symfun(F,t);
    plot(X,f(X));
    saveas(gcf,'/Users/user/Desktop/ECT/Q1/pic10.jpg','jpg');
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %R=1 , W=1.1
    H11=(i*1.1)/(1+(i*1.1)+(i*1.1)^2);
    m11=abs(H11);
    ang11=atan(imag(H11)/real(H11));
    Hsign=sign(real(H11));
    Hsigntest=(Hsign==-1);
    Hsign2=Hsigntest.*sign(imag(H11));
    ang11=ang11+pi*Hsign2;
    
    plot(X,m11*cos(1.1*X-pi/2+ang11));
    saveas(gcf,'/Users/user/Desktop/ECT/Q1/pic11.jpg','jpg');
    %R=1 , W=1
    H12=i/(1+i+i^2);
    m12=abs(H12);
    ang12=atan(imag(H12)/real(H12));
    Hsign=sign(real(H12));
    Hsigntest=(Hsign==-1);
    Hsign2=Hsigntest.*sign(imag(H12));
    ang12=ang12+pi*Hsign2;
    
    plot(X,m12*cos(X-pi/2+ang12));
    saveas(gcf,'/Users/user/Desktop/ECT/Q1/pic12.jpg','jpg');
    %R=1 , W=0.9
    H13=(i*0.9)/(1+(i*0.9)+(i*0.9)^2);
    m13=abs(H13);
    ang13=atan(imag(H13)/real(H13));
    Hsign=sign(real(H13));
    Hsigntest=(Hsign==-1);
    Hsign2=Hsigntest.*sign(imag(H13));
    ang13=ang13+pi*Hsign2;
    
    plot(X,m13*cos(0.9*X-pi/2+ang13));
    saveas(gcf,'/Users/user/Desktop/ECT/Q1/pic13.jpg','jpg');
    %R=20 , W=1.1
    H21=(i*1.1)/(20+(i*1.1)+20*(i*1.1)^2);
    m21=abs(H21);
    ang21=atan(imag(H21)/real(H21));
    Hsign=sign(real(H21));
    Hsigntest=(Hsign==-1);
    Hsign2=Hsigntest.*sign(imag(H21));
    ang21=ang21+pi*Hsign2;
    
    plot(X,m21*cos(1.1*X-pi/2+ang21));
    saveas(gcf,'/Users/user/Desktop/ECT/Q1/pic14.jpg','jpg');
    %R=20 , W=1
    H22=i/(20+i+20*i^2);
    m22=abs(H22);
    ang22=atan(imag(H22)/real(H22));
    Hsign=sign(real(H22));
    Hsigntest=(Hsign==-1);
    Hsign2=Hsigntest.*sign(imag(H22));
    ang22=ang22+pi*Hsign2;
    
    plot(X,m22*cos(X-pi/2+ang22));
    saveas(gcf,'/Users/user/Desktop/ECT/Q1/pic15.jpg','jpg');
    %R=20 , W=0.9
    H23=(i*0.9)/(20+(i*0.9)+20*(i*0.9)^2);
    m23=abs(H23);
    ang23=atan(imag(H23)/real(H23));
    Hsign=sign(real(H23));
    Hsigntest=(Hsign==-1);
    Hsign2=Hsigntest.*sign(imag(H23));
    ang23=ang23+pi*Hsign2;
    
    plot(X,m23*cos(0.9*X-pi/2+ang23));
    saveas(gcf,'/Users/user/Desktop/ECT/Q1/pic16.jpg','jpg');
    
end