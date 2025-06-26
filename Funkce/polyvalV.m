function y = polyval(c, s)
    n = length(c) - 1;
    B = s .^ (0:n);
    y = B * c;
end
