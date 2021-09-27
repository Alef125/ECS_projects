function [lambda, x] = basic_power_method(A, tol)
% Power Method
x = gershgorin_starter(A);
e = 1 + tol;  % to make sure we enter the while
while e > tol
    x_next = A * x;
    x_next = x_next / max(abs(x_next));
    delta_x = x_next-x;
    e = sqrt(delta_x'*delta_x);
    x = x_next;
end
lambda = (x'*A*x)/(x'*x);
end

