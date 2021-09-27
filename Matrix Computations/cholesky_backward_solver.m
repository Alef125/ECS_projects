function x = cholesky_backward_solver(a_diag, a_down, y, n)
% solver for Ux=y, and U is given by diag and lower diag
x = zeros(1, n);
x(n) = y(n) / a_diag(n);
for i = n-1:-1:1
    x(i) = (y(i) - a_down(i) * x(i+1)) / a_diag(i);
end
end

