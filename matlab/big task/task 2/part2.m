function part2()
file = load('data11.mat'); 
tt = file.tt; 
x1 = file.xx; 
x2 = file.yy; 
x1_f = {@(t)exp(-5.*t).*cos(5.*t), @(t)exp(-5.*t).*sin(5.*t), @(t)1, @(t)0};
x2_f = {@(t)-exp(-5.*t).*sin(5.*t), @(t)exp(-5.*t).*cos(5.*t), @(t)0, @(t)1};
f_x1 = gen_func(x1_f, tt, x1);
f_x2 = gen_func(x2_f, tt, x2);

xx = linspace(tt(1),tt(end), 10000);
figure;
x1_t = f_x1(xx); 
%plot(tt, x1, '--r');
hold on;
%plot(tt, x1_t, '*b');


figure;
x2_t = f_x2(xx); 
plot(x1_t, x2_t, '--r');
hold on;
plot(x1, x2, '*gr');
%plot(tt, x2_t, '*b');
end