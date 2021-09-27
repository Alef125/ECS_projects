function [a_diag, a_down] = tridiagonal_cholesky(a_diag, a_down, n)
% a_down: a vector with (n-1) elements containig lower diag elements 
% a_diag: a vector with n elements containig main diag elements 
    a_diag(1) = sqrt(a_diag(1));
    for k = 2:n
        a_down(k-1) = a_down(k-1) / a_diag(k-1);
        a_diag(k) = sqrt(a_diag(k) - a_down(k-1) * a_down(k-1));
    end
end


