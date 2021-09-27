function z = lower_solve(L, b)
% L: lower triangular with only 1 on the diagonal
n = length(b);
z = zeros(n, 1);
for i=1:n
    s=0;
    for j=1:i-1
        s = s + L(i,j)* b(j);
    end
    z(i) = b(i) - s;
end
end

