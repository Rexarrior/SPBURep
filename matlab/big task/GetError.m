function error = GetError(x0, x1, func_true, func_computed, count_of_points)
    if nargin < 5
        count_of_points = abs(x1 - x0) * 100; 
    end
    x = linspace(x0, x1, count_of_points);
    error = GetMaxDiff(x, func_true, func_computed); 
end


function diff = GetMaxDiff(x, func1, func2)
    diff = max(abs(func1(x) - func2(x))); 
end