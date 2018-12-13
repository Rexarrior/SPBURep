function f = get_F(x)
    d = get_diff(x);
    f = @(t) t .*(d(t)).^2 + ((x(t)).^2)./t;
end