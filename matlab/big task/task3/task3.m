%F = @(t) t + t.^2 ;
%F = @(t) t .* (1 - 1./(t.^2)).^2 + ((t + 1./t).^2)./t   ;
%n = 1000; 
%integral(F, 1, 2)

a = 1; 
b = 2; 

[res, xx] = optimization(1e-3, 10);
n = length(xx);
tt = linspace(a,b, n);
x = approx_f(tt, xx, 10);
d = get_diff(x);


