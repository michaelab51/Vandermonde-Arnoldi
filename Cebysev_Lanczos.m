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
