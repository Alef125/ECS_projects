function HW4_Q3()
    %Ncuts
    text=fopen('/Users/user/Desktop/HW4/Points.txt','rt');
    n= textscan(text,'%f',1);
    x=ones(1,n{1});
    y=ones(1,n{1});
    for k=1:n{1}
        P=textscan(text,'%f %f',1);
        y(k)=P{1};
        x(k)=P{2};
    end
    mx=min(min(x));
    my=min(min(y));
    Mx=max(max(x));
    My=max(max(y));
    Lx=fix(40*(Mx-mx));
    Ly=fix(40*(My-my));
    A=zeros(Lx,Ly);
    x=1+fix(((x-mx)/(Mx-mx))*(Lx-1));
    y=1+fix(((y-my)/(My-my)*(Ly-1)));
    for k=1:n{1}
        A(x(k),y(k))=1;
    end
    fclose(text);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    W=zeros(n{1});
    r=100;
    sigmar=70;
    for i=1:n{1}
        for j=1:n{1}
            dd=(x(i)-x(j))^2+(y(i)-y(j))^2;
            if (dd<r^2)
                W(i,j)=exp(-(dd)/sigmar);
            end
        end
    end
    imagesc(W);
    saveas(gcf,'/Users/user/Desktop/HW4/im06.jpg','jpg');
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    d=sum(W);
    D=eye(n{1}).*(d'*ones(1,n{1}));
    DV=inv(sqrt(D));
    M=DV*(D-W)*DV;
    imagesc(M);
    saveas(gcf,'/Users/user/Desktop/HW4/im07.jpg','jpg');
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    [V,Lambda]=eigs(M,2,'sm');
    lambda=Lambda(1);
    v=V(:,1);
    size(v);
    seg=DV*v;
    %plot(seg);
    for k=1:n{1}
        if (seg(k)>0.02)
          A(x(k),y(k))=2;
        end
    end
    imagesc(A);
    saveas(gcf,'/Users/user/Desktop/HW4/im08.jpg','jpg');
end

