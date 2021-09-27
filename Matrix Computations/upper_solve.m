function x = upper_solve(U, z)
% U: upper triangular
n = length(z);
x = zeros(n, 1);
for i=n:-1:1
    s=0;
    for j=i+1:n
        s = s + U(i,j)* x(j);
    end
    x(i) = (z(i) - s) / U(i,i);
end
end
