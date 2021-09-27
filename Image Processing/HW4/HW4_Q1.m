function HW4_Q1();
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
    imagesc(A);
    saveas(gcf,'/Users/user/Desktop/HW4/im01.jpg','jpg');
    
    
    Data=[x',y'];
    IDX=kmeans(Data,2);
    scatter(x,y,10,IDX,'filled');
    saveas(gcf,'/Users/user/Desktop/HW4/im02.jpg','jpg');
    
    [IDX,B,C] = HGMeanShiftCluster(Data,70,'flat',1);
    %scatter(x,y,10,IDX,'filled');
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
%nPtsPerClust = 250;
%nClust  = 3;
%totalNumPts = nPtsPerClust*nClust;
%x = var*randn(2,nPtsPerClust*nClust);
%[clustCent,point2cluster,clustMembsCell] = MeanShiftCluster(x,0.75);
numClust = length(C);
figure(10),clf,hold on
cVec = 'bgrcmykbgrcmykbgrcmykbgrcmyk';
for k = 1:min(numClust,length(cVec))
    myMembers = C{k};
    myClustCen = IDX(:,k);
    %plot(A(1,myMembers),A(2,myMembers),[cVec(k) '.'])
    %plot(myClustCen(1),myClustCen(2),'o','MarkerEdgeColor','k','MarkerFaceColor',cVec(k), 'MarkerSize',10)
end
title(['no shifting, numClust:' int2str(numClust)])
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    Data=sqrt( (x-Lx/2).^2 + (y-Ly/2).^2 );
    IDX=kmeans(Data',2);
    scatter(x,y,10,IDX,'filled');
    saveas(gcf,'/Users/user/Desktop/HW4/im04.jpg','jpg');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end

