function J=hor_col(I,n,sigma); 
    % This function affects a Gaussian vertical Filter
    % whit characters (2*n+1*1) and sigma on image I
    Y=[-n:n];
    
    Gy=(exp(-(Y.*Y)/(2*sigma*sigma)));
    Gy=Gy/sum(Gy);
    
    x=size(I(:,1,1),1);
    y=size(I(1,:,1),2);
    J1=zeros(x-2*n,y,3);
    
    for j=-n:n
            J1=J1+  double(Gy(n+j+1)  *  double(I( [(n+j+1):(x+j-n)]  ,: ,: )));
    end
    
    %zero taking
    J2=zeros(x,y,3);
    J2([n+1:x-n],:,:)=J1;
    J=J2;
    
end