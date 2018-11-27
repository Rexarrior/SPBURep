function x =  ChebyshevNodes(count)
  %  x = roots(ChebyshevCoeff(count + 1));
  %  x = reshape(x, 1, length(x));
  %  x = sort(x);
  x = 1 : count;
  x = 2  * x; 
  x = x - 1; 
  x = x / 2; 
  x = x / count; 
  x = x * pi; 
  x = cos(x); 
   
end





