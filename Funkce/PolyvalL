function y = polyvalL(c, T, s, m)
    M = length(s);
    V = zeros(M, length(c));

    V(:,1) = ones(M,1) / sqrt(m);
    if isscalar(c)
        y = V * c;
        return;
    end

    w = s .* V(:,1);
    w = w - T(1,1) * V(:,1);
    V(:,2) = w / T(1,2);

    for j = 3:length(c)
        w = s .* V(:,j-1);
        w = w - T(j-1,j-1) * V(:,j-1) - T(j-2,j-1) * V(:,j-2);
        V(:,j) = w / T(j-1,j);
    end

    y = V * c;
end
