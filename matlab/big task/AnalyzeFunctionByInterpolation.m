function AnalyzeFunctionByInterpolation(func, x0, x1, eps)
% Interpolation methods
lagrange = @(x,y) Lagrange(x, y);
linearInterpolation = @(x,y) LinearSystemInterpolation(x, y);


if nargin < 4
    eps = 1e-3;
end
disp('Анализируем ф-ю:');
%lagrange
disp(func);
disp('Требуемая точность:');
disp(eps);
disp('Область интерполяции: ')
disp(x0);
disp(x1);
[n, error] = FindError(eps, x0, x1, func, lagrange, 100); 
disp('При интерполяции методом Лагранжа требуемая точность  была достигнута при n=');
disp(n);
disp('Ошибка при данном n составила:'); 
disp(error);

%linear system
[n, error] = FindError(eps, x0, x1, func, linearInterpolation, 100); 
disp('При интерполяции c помощью системы линейных уравнений требуемая точность была достигнута при n=');
disp(n);
disp('Ошибка при данном n составила:'); 
disp(error);

%chebyshev lagrange
[n, error] = FindError_Chebyshev(eps, func, lagrange, 100); 
disp('При интерполяции c помощью полиномов в форме лагранжа с чебышевскими узлами требуемая точность была достигнута при n=');
disp(n);
disp('Ошибка при данном n составила:'); 
disp(error);


%chebyshev linear
[n, error] = FindError_Chebyshev(eps, func, linearInterpolation, 100); 
disp('При интерполяции c помощью системы линейных уравнений с чебышевскими узлами требуемая точность была достигнута при n=');
disp(n);
disp('Ошибка при данном n составила:'); 
disp(error);

end