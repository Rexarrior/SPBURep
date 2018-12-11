function a = get_a(f, y, x)
    m = 0; 
    M = 0.1; 
    n = (M - m) / 1e-4;
    a_v  = linspace(m, M, n);
    min_v = compute_g(f, a_v(1), y, x);
    a = a_v(1);
    for i = 2:length(a_v)
        val = compute_g(f, a_v(i), y, x);
        if val < min_v
            min_v = val;
            a = a_v(i);
        end        
    end   
  
end




function v  = compute_g(f, a, y, x)
    xx = x + a.*y; 
    xx(1) = x(1);
    xx(end) = x(end); 
    v = f( xx);
end