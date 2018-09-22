A = [[1 2 3], [4 5 6]];
B = [11 12 -2 -10];
disp( min(min(A(~ismember(A, B)))));