function [n, error] = FindError_Chebyshev(eps, func, method_of_interpolation, max_n)
    if nargin < 4
        max_n = 10000;
    end
    coeff = 10;
    error = +inf;
    n = 3;
    while error > eps && n < max_n
        x = ChebyshevNodes(n);
        y = func(x); 
        f = method_of_interpolation(x, y);
        error = GetError(x(1), x(end), func, f, coeff * n); 
        n = n + 1; 
    end
    if n >= max_n
        error = -1; 
        n = -1; 
    end
    
end