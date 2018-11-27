function [n, error] = FindError(eps, x0, x1, func, method_of_interpolation, max_n)
    if nargin < 6
        max_n = 10000;
    end
    coeff = 10;
    error = +inf;
    n = 1;
    while error > eps && n < max_n
        [x, y] = GetData(func, x0, x1, n);
        f = method_of_interpolation(x, y);
        error = GetError(x0, x1, func, f, coeff * n); 
        n = n + 1; 
    end
    if n >= max_n
        error = -1; 
        n = -1; 
    end
    
end