function c = polyfit(x, f, n)
    A = x .^ (0:n);
    c = A \ f;
end
