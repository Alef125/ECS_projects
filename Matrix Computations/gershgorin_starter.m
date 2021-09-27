function x = gershgorin_starter(A)
% A vector in Gershgorin circles
d = diag(A);
[~, m] = min(abs(d));
x = d * 0;  % = zeros(shape(d))
x(m) = 1;
end

