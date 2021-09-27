function J=ECT_Q2();
    text=fopen('/Users/user/Desktop/ECT/Q2/Elements.txt','rt');
    
    ss=cell(100,8);
    s=textscan(text,'%s %s %f %f %f %f',1);
    ss{1,1}=s{1,1};
    ss{1,2}=s{1,2};
    ss{1,3}=s{1,3};
    ss{1,4}=s{1,4};
    ss{1,5}=s{1,5};
    ss{1,6}=s{1,6};
    k=1;
    while ~feof(text)
        k=k+1;
        s= textscan(text,'%s %s %f %f %f %f',1);
        ss{k,1}=s{1,1};
        ss{k,2}=s{1,2};
        ss{k,3}=s{1,3};
        ss{k,4}=s{1,4};
        ss{k,5}=s{1,5};
        ss{k,6}=s{1,6};
    end
    k=k-1;
    
    M=[-1 1 0 0 0 -1;
        1 0 0 1 -1 0;
        0 -1 1 -1 0 0];
    
    % Mv=0 & M'I=j & Pv=Zj+v0
    Z=zeros(k,k);
    P=zeros(k,k);
    v0=zeros(k,1);
    for kk=1:k
        t=ss{kk,2};
        if(t{1}=='R')
            Z(kk,kk)=ss{kk,5};
            P(kk,kk)=1;
        elseif (t{1}=='V')
            v0(kk)=ss{kk,5};
            P(kk,kk)=1;
        elseif (t{1}=='I')
            Z(kk,kk)=1;
            v0(kk)=-ss{kk,5};
        elseif (t{1}=='JV')
            Z(kk,kk)=1;
            P(kk,ss{kk,6})=ss{kk,5};
        end 
    end
    % New Vector is I_V, C(I_V)=D(I_V)+V0(new)
    C=zeros(9,9);
    C(1:6,4:9)=P;
    C(7:9,4:9)=M;
    D=zeros(9,9);
    D(1:6,1:3)=Z*M';
    V0=zeros(9,1);
    V0(1:6)=v0;
    ANS=(C-D)'*V0;
    J=M'*ANS(1:3);
    
    %Voltages
        ss{1,8}=ANS(4);
        ss{2,8}=ANS(5);
        ss{3,8}=ANS(6);
        ss{4,8}=ANS(7);
        ss{5,8}=ANS(8);
        ss{6,8}=ANS(9);
    %Currents
        ss{1,7}=J(1);
        ss{2,7}=J(2);
        ss{3,7}=J(3);
        ss{4,7}=J(4);
        ss{5,7}=J(5);
        ss{6,7}=J(6);
        
        
        fid=fopen('/Users/user/Desktop/ECT/Q2/End.txt','w');
        for i=1:6
            d1=ss{i,1};
            fprintf(fid,'%s ',d1{1});
            d2=ss{i,7};
            fprintf(fid,'%d ',d2);
            d3=ss{i,8};
            fprintf(fid,'%d ',d3);
            d4=d3*d2;
            fprintf(fid,'%d\n',d4);
        end
        fclose(fid);
     
end

