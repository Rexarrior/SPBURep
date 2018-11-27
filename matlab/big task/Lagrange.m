function [lagr] = Lagrange(x, y)
    lagr = @(xx) ComputeLagrange(x, y, xx);
end

function [yy] = ComputeLagrange(x, y, xx)
    n = length(y) ;
    xx_size = length(xx);
    Phi = ones(n, xx_size);
    for k=1:n
        for j = [1:k-1  k+1 : n]        
            t = (xx - x(j)) / (x(k) - x(j));
            Phi(k,:) = Phi(k,:) .* t;
        end
            
    end
    yy = y * Phi;
end