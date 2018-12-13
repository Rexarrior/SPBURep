function [coeffMatr] = get_coeff(prodFuncs, x)
len = size(x);
len2 = size(prodFuncs);
if len(2) ~= len2(2)
    ex = MException('get_coeff: wrong arguments', 'dimenstions of  x and prodFuncs  must be agreed');
    throw(ex);
end
coeffMatr = zeros(len);

for i=1:len(1)
    for j=1:len(2)
        func = prodFuncs{j};
        coeffMatr(i, j) = func(x(i,j));
    end
end
end