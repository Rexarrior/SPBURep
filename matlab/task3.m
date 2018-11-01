n = 10;
A = diag(-2*ones(n,1));
A = A + diag(ones(n-1,1), -1);
A = A + diag(ones(n-1,1), 1);
A(end,1) = 1;
A(1,end) = 1;
disp(A);
disp(rank(A));