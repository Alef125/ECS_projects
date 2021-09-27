function [a_up, a_diag, a_down] = tridiagonal_LU(a_up, a_diag, a_down, n)
% a_down: a vector with (n-1) elements containig lower diag elements 
% a_up  : a vector with (n-1) elements containig upper diag elements 
% a_diag: a vector with n elements containig main diag elements 
    for k = 1:n-1
        a_down(k) = a_down(k) / a_diag(k);
        a_diag(k+1) = a_diag(k+1) - a_down(k) * a_up(k);
    end
end

