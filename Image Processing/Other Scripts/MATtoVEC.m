% Making a group of numbera in 4D matrix as A, a vector
function V = MATtoVEC( A , n )
    V=zeros(1,n);
    for i=1:n
        V(i)=A(:,:,i,:);
    end
end
