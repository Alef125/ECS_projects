function y = cholesky_forward_solver(a_diag, a_down, b, n)
% solver for Ly=b, in which L is given by 2 diagonal vectors
y = zeros(1, n);
y(1) = b(1) / a_diag(1);
for i = 2:n
    y(i) = (b(i) - a_down(i-1) * y(i-1)) / a_diag(i);
end
end

