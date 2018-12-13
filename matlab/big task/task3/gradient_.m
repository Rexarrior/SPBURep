function grad = gradient_(func, x, eps)
    if nargin < 3
        eps = 1e-3;
    end
    grad = zeros(size(x));
    for i=1:length(x)
        b = x;
        b(i) = b(i) + eps; 
        grad(i) = (func(b) - func(x)) / eps;        
    end
end