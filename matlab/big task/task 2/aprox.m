function [y_a] =  aprox(x, y, degree)
    p = polyfit(x, y, degree);
    y_a = polyval(p, x); 
end