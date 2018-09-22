A = [2 3 4 5 4 3 2];
if (mod(length(A), 2) == 1)
midle = ceil(length(A) / 2);
A(midle) = [];
end
midle = length(A) / 2;

disp(all(A(1:1:midle) == A(length(A) : -1 : midle + 1 ) )) 