A = [1 2 3; 4 5 6 ];
B = [11 12; -2 -10];
A = A(:);
B = B(:).';

C = A + B;
SIN = sin(C);
disp(max(SIN));