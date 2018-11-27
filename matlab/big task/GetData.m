function [x, y] = GetData(f, first, last , count)
    x = linspace(first, last, count);
    y = f(x);
end
