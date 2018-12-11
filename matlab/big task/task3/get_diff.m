function d = get_diff(f, x, eps)
    if nargin < 3
        eps = 1e-5;
    end   
    d = @(x)(f(x + eps) - f(x)) / eps;
end