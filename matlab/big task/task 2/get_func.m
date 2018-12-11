function f =  get_func(funcs, coeff)
    f = @(t)compute_func(funcs, coeff, t);
end

function sum = compute_func(funcs, coeff, t)
sum = 0;
for i=1:length(funcs)
    sum = sum +  funcs{i}(t) * coeff(i);
end
end