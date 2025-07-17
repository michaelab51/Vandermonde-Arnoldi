addpath('Funkce');

% Diskretizace domény
n = 80;
x1 = linspace(-1, -1/3, 500)';
x2 = linspace(1/3, 1, 500)';
x = [x1; x2];

% Cílová funkce
f = sign(x);

% Aproximace pomocí Lanczosova algoritmu
[c, T, m, V] = polyfitL(x, f, n);

%výpočet ztráty ortogonality
loss_ort = norm(eye(size(V,2)) - V' * V, 'fro');
fprintf('Ztráta ortogonality: %.3e\n', loss_ort);

% Evaluace výsledného polynomu
s = linspace(-1, 1, 1000)';
y = polyvalL(c, T, s, m);

% Výpočet skutečné hodnoty funkce
sign_x = sign(s);
error = abs(y - sign_x);

% Grafické zobrazení
figure;
subplot(2,1,1);
plot(s, sign_x, 'k', 'LineWidth', 3); hold on;
plot(s, y, 'm--', 'LineWidth', 3);
title('Aproximace funkce sign(x) (Lanczos)', 'FontSize', 16);
xlabel('x', 'FontSize', 14);
ylabel('p(x)', 'FontSize', 14);
legend('Funkce', 'Approximace', 'Location', 'southeast', 'FontSize', 12);
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
