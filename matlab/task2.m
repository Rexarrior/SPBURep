n = 10;
b = 1:n;
reshape(b,n,1);
A = repmat(b, n, 1);

disp(A);

oness = ones(n,n);
A = oness .* b; 
disp(A');
