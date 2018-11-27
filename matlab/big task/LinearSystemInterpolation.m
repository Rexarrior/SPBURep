function [f, a] =  LinearSystemInterpolation(x, y)
    x = vander(x);
    a = x \ y';
    f = @(xx) polyval(a, xx); 
end

