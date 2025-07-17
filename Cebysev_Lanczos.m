addpath('Funkce');

% Generování Čebyševových uzlů
n = 80;
j = (0:n)';
x = cos(j * pi / n);

% Cílová funkce
f = 1 ./ (1 + 25 * x.^2);

% Interpolace pomocí Lanczosova algoritmu
[c, T, m, V] = polyfitL(x, f, n);

% Evaluace výsledného polynomu
s = linspace(-1, 1, 1000)';
y = polyvalL(c, T, s, m);

% Výpočet skutečné funkční hodnoty
y_exact = 1 ./ (1 + 25 * s.^2);
error = abs(y - y_exact);

%výpočet ztráty ortogonality
loss_ort = norm(eye(size(V,2)) - V' * V, 'fro');
fprintf('Ztráta ortogonality: %.3e\n', loss_ort);

% Grafické zobrazení
figure;
subplot(2,1,1);
plot(s, y_exact, 'k', 'LineWidth', 3); hold on;
plot(s, y, 'm--', 'LineWidth', 3);
title('Interpolace v Čebyševových bodech (Lanczos)', 'FontSize', 16);
xlabel('x', 'FontSize', 14);
ylabel('p(x)', 'FontSize', 14);
legend('Funkce', 'Aproximace', 'FontSize', 12);
grid on;
set(gca, 'FontSize', 12);

subplot(2,1,2);
semilogy(s, error, 'r', 'LineWidth', 3);
xlim([-1 1]);
title('Vektor chyby', 'FontSize', 16);
xlabel('x', 'FontSize', 14);
ylabel('|p(x) - f(x)|', 'FontSize', 14);
grid on;
set(gca, 'FontSize', 12);
