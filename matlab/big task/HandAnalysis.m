f2 = @(x) 1 ./ (1 + 12*x.^2);
x2_0 = -0.5;
x2_1 = -0.1;
x2_2 = 0.1;
x2_3 = 1;

n = 100;
[x1, y1] = GetData(f2, -1, 1, n); 
x = ChebyshevNodes(n);
y = f2(x);
f_1 = Lagrange(x, y);
f_2 = Lagrange(x1, y1);
x = linspace(-1, 1, 10*n);
y = f2(x);
yy = f(x);
d = y - yy; 

figure()
axes()

plot(x, yy, 'color', 'r');
hold on; 
plot(x,y, 'color', 'b');
hold on; 
grid on; 