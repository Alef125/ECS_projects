function [lambda, x] = inverse_power_method(A, tol)
% Power Method with A^-1
% PA = LU => A*x_k+1=x_k: LU*x_k+1=P*x_k
[L, U, P] = lu(A);
x = gershgorin_starter(A);
e = 1 + tol;  % to make sure we enter the while
while e > tol
    z = lower_solve(L, P*x);
    x_next = upper_solve(U, z);
    x_next = x_next / max(abs(x_next));
    delta_x = x_next-x;
    e = sqrt(delta_x'*delta_x);
    x = x_next;
end
y = A*x;  % x = A^-1 * y
lambda = (y'*y)/(y'*x);
end