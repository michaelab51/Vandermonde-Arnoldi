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

% Diskretizace domény pro least squares problém
n = 80;
x1 = linspace(-1, -1/3, 500)';
x2 = linspace(1/3, 1, 500)';
x = [x1; x2];

% Cílová funkce
f = sign(x);

% Aproximace pomocí Lanczosova algoritmu
[c, T] = polyfitA(x, f, n);

% Evaluace výsledného polynomu
s = linspace(-1, 1, 1000)';
y = polyvalA(c, T, s);

% Výpočet skutečné hodnoty funkce sign(x)
sign_x = sign(s);
error = abs(y - sign_x);

% Grafické zobrazení
figure;
subplot(2,1,1);
plot(s, sign_x, 'k', 'LineWidth', 2); hold on;
plot(s, y, 'g--', 'LineWidth', 2);
title('Aproximace funkce sign(x) (Lanczos)');
xlabel('x');
ylabel('p(x)');
legend('sign(x)', 'Approximace');
grid on;

subplot(2,1,2);
plot(s, error, 'r', 'LineWidth', 2);
xlim([0 1]);
title('Aproximační chyba');
xlabel('x');
ylabel('|p(x) - sign(x)|');
grid on;
