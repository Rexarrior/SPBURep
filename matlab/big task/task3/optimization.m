function [ret, xx] = optimization(eps, n) 
    a = 1;
    b = 2;
    x_a = 2; 
    x_b = 2.5; 
    
    %n = 5;     
    xx = linspace(x_a, x_b, n);    
    f = @(x)compute_integral(a,b, x);
    lf = f(xx);    
    while 1
        grad = gradient_(f, xx);
        y = -grad; 
        a = get_a(f, y, xx);
        xx = xx + a .* y;  
        xx(1) = x_a; 
        xx(end) = x_b; 
        cf = f(xx);
        if abs(cf - lf) < eps
            break
        end
        lf = cf; 
    end
    
    ret = f(xx); 
end