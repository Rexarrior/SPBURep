% Initializing...
warning('off', 'all');
%funcs and input sections
f1 = @(x) sin(x); 
x1_0 = -5 * pi; 
x1_1 = 5 * pi; 


f2 = @(x) 1 ./ (1 + 12*x.^2);
x2_0 = -1;
x2_1 = 1;
x2_2 = 0.1;
x2_3 = 1;


% find n for error=1e-3
AnalyzeFunctionByInterpolation(f1, x1_0, x1_1);

AnalyzeFunctionByInterpolation(f2, x2_0, x2_1);
%AnalyzeFunctionByInterpolation(f2, x2_2, x2_3);

warning('on', 'all');