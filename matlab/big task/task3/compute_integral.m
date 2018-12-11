function [res, F] = compute_integral(a, b, xx)
    n = length(xx);
    tt = linspace(a,b, n);
    x = approx_f(tt, xx, 10);
    F = get_F(x);
    res = integral(F, a, b);
end
