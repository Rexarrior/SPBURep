function y_a =  aprox_n(x, y)
    p = polyfit(x, log(y), 1);
    y_a =  exp( polyval(p, x));
end