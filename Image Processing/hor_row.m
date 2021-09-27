function J=hor_row(I,n,sigma); 
    % This function affects a Gaussian Horizontal Derivative Filter
    % whit characters (1*2*n+1) and sigma on image I
    X=[-n:n];
    
    Gx=X.*(exp(-(X.*X)/(2*sigma*sigma)));
    Gx=Gx/(sqrt(2*pi)*sigma^3);
    
    x=size(I(:,1,1),1);
    y=size(I(1,:,1),2);
    J1=zeros(x,y-2*n,3);
    
    for i=-n:n
            J1=J1+  double( Gx(n+i+1)  *  double(I( :,  [(n+i+1):(y+i-n)] ,: )) );
    end
    
    %zero taking
    J2=zeros(x,y,3);
    J2(:,[n+1:y-n],:)=J1;
    J=J2;
    
end