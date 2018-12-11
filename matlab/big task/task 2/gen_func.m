function f = gen_func(funcs, x, y)
    coeff = get_coeff(funcs, repmat(x, 1, length(funcs))); 
    consts = coeff \ y; 
    f = get_func(funcs, consts);
end