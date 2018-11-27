
function coeff = ChebyshevCoeff(n)
  coeff_last = zeros(1,n);  
  coeff_last(1) = 1; 
  coeff = zeros(1,n); 
  coeff(2) = 1;
  
  for i = 3:n
    new_coeff = zeros(1,n);
    new_coeff(2:i)= coeff(1:i-1) * 2;
    new_coeff = new_coeff - coeff_last;
    coeff_last = coeff; 
    coeff = new_coeff; 
  end
  coeff = coeff(end:-1:1);
end

