function f = approx_f(x, y, degree)
    p = polyfit(x, y, degree);
    f = @(x)polyval(p, x);
end