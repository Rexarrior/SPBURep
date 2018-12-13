file = load('data.mat'); 
x = file.V; 
y1 = file.b1f; 
y2 = file.b2f; 

% ������������� y1 �������� �������� 
y_1 = aprox(x, y1, 1);
plot(x, y_1, '--r');
hold on;
plot(x, y1, '*b');


% ������������� y2 ���������� ��������
y_2 = aprox(x, y2, 3);
plot(x, y_2, '*r');
hold on;
plot(x, y2, '--b');

figure

y_1_n = aprox_n(x, y1);
plot(x, y_1_n, '*r');
hold on; 
plot(x, y1, '--b');

% part 2
