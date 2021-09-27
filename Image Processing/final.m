function JJ=final();
    threshold=37;
    I=imread('/Users/user/Downloads/HW2/Books.jpg');
    n=20;
    sigma=7;
    J=gradient(I,n,sigma);
    JJ=J>threshold;
end