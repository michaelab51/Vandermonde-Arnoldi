function [c, T, m, V] = polyfitL(x, f, n)
    m = length(x);
    V = zeros(m, n+1);
    T = zeros(n+1, n+1);

    V(:,1) = ones(m,1) / sqrt(m);
    if n == 0
        c = V \ f;
        return;
    end

    w = x .* V(:,1);
    T(1,1) = V(:,1)' * w;
    w = w - T(1,1) * V(:,1);

    for j = 2:n+1
        T(j-1,j) = norm(w);
        if T(j-1,j) == 0
            break;
        end
        V(:,j) = w / T(j-1,j);
        w = x .* V(:,j);
        T(j,j) = V(:,j)' * w;
        w = w - T(j,j) * V(:,j) - T(j-1,j) * V(:,j-1);
    end

    c = V'* f;
end
