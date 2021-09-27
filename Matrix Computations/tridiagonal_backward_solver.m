function x = tridiagonal_backward_solver(a_diag, a_up, y, n)
% solver for Ux=y, and U is given by diag and lower diag vactor of A 
x = zeros(1, n);
x(n) = y(n) / a_diag(n);
for i = n-1:-1:1
    x(i) = (y(i) - a_up(i) * x(i+1)) / a_diag(i);
end
end

