function y = tridiagonal_forward_solver(a_down, b, n)
% solver for Ly=b, and L is given by lower diag vactor of A in size (n-1)
y = zeros(1, n);
y(1) = b(1);
for i = 2:n
    y(i) = b(i) - a_down(i-1) * y(i-1);
end
end

