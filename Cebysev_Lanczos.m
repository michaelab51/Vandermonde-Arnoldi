function [c, T] = polyfitA(x, f, n)
    m = length(x);
    V = zeros(m, n+1);
    T = zeros(n+1, n+1);

    V(:,1) = ones(m,1) / norm(ones(m,1));
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

    c = V \ f;
end

function y = polyvalA(c, T, s)
    M = length(s);
    V = zeros(M, length(c));

    V(:,1) = ones(M,1) / norm(ones(M,1));
    if length(c) == 1
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

% Generování Čebyševových uzlů
n = 20;
j = (0:n)';
x = cos(j * pi / n);

% Cílová funkce
f = 1 ./ (1 + 25 * x.^2);

% Interpolace pomocí Lanczosova algoritmu
[c, T] = polyfitA(x, f, n);

% Evaluace výsledného polynomu
s = linspace(-1, 1, 1000)';
y = polyvalA(c, T, s);

% Výpočet skutečné funkční hodnoty
y_exact = 1 ./ (1 + 25 * s.^2);
error = abs(y - y_exact);

% Grafické zobrazení
figure;
subplot(2,1,1);
plot(s, y_exact, 'k', 'LineWidth', 3); hold on;
plot(s, y, 'm--', 'LineWidth', 3);
title('Interpolation in Chebyshev Points (Lanczos)');
xlabel('x');
ylabel('p(x)');
legend('Exact function', 'Interpolant');
grid on;

subplot(2,1,2);
semilogy(s, error, 'r', 'LineWidth', 3);
xlim([0 1]);
title('Interpolation Error (Lanczos)');
xlabel('x');
ylabel('||p(x) - f(x)||_2');
grid on;
