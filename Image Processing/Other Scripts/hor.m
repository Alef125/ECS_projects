function J=hor(I,n,sigma);
    G=XDGauss(n,sigma);
    J=conv2d(I,-G);
end

