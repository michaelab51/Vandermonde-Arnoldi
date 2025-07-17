addpath('Funkce');

% Generování dat
n = 100;
x = linspace(-pi, pi, n)';
f_true = sin(x) .* cos(3*x);
noise = 0.1 * randn(size(x));
f_noisy = f_true + noise;

% Aproximace pomocí polynomu
degree = 30; 
[d, H] = polyfitA(x, f_noisy, degree);

% Evaluace polynomu
s = linspace(-pi, pi, 1000)';
y_fit = polyvalA(d, H, s);
y_exact = sin(s) .* cos(3*s);

% Výpočet RMSE
rmse = sqrt(mean((polyvalA(d, H, x) - f_true).^2));

% Vykreslení výsledků
figure;
plot(x, f_noisy, 'bo', 'MarkerFaceColor', 'b', 'DisplayName', 'Data'); hold on;
plot(s, y_exact, 'g-', 'LineWidth', 3, 'DisplayName', 'Pravá funkce');
plot(s, y_fit, 'r--', 'LineWidth', 3, 'DisplayName', 'Aproximace');
legend('Location', 'southeast', 'FontSize', 12);
title(['Aproximace funkce sin(x)cos(3x)'], 'FontSize', 16);
xlabel('x', 'FontSize', 14);
ylabel('p(x)', 'FontSize', 14);
grid on;

