file = load('data.mat'); 
x = file.V; 
y1 = file.b1f; 
y2 = file.b2f; 

f1 = Lagrange(x,y1); 

xx = linspace(x(1), x(end), 1000); 
plot(x, y2, 'c*'); 