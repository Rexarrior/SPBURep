function AnalyzeFunctionByInterpolation(func, x0, x1, eps)
% Interpolation methods
lagrange = @(x,y) Lagrange(x, y);
linearInterpolation = @(x,y) LinearSystemInterpolation(x, y);


if nargin < 4
    eps = 1e-3;
end
disp('����������� �-�:');
%lagrange
disp(func);
disp('��������� ��������:');
disp(eps);
disp('������� ������������: ')
disp(x0);
disp(x1);
[n, error] = FindError(eps, x0, x1, func, lagrange, 100); 
disp('��� ������������ ������� �������� ��������� ��������  ���� ���������� ��� n=');
disp(n);
disp('������ ��� ������ n ���������:'); 
disp(error);

%linear system
[n, error] = FindError(eps, x0, x1, func, linearInterpolation, 100); 
disp('��� ������������ c ������� ������� �������� ��������� ��������� �������� ���� ���������� ��� n=');
disp(n);
disp('������ ��� ������ n ���������:'); 
disp(error);

%chebyshev lagrange
[n, error] = FindError_Chebyshev(eps, func, lagrange, 100); 
disp('��� ������������ c ������� ��������� � ����� �������� � ������������ ������ ��������� �������� ���� ���������� ��� n=');
disp(n);
disp('������ ��� ������ n ���������:'); 
disp(error);


%chebyshev linear
[n, error] = FindError_Chebyshev(eps, func, linearInterpolation, 100); 
disp('��� ������������ c ������� ������� �������� ��������� � ������������ ������ ��������� �������� ���� ���������� ��� n=');
disp(n);
disp('������ ��� ������ n ���������:'); 
disp(error);

end