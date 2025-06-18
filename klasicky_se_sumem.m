% 1. Definice cílové funkce
f = @(x) sin(x) .* cos(3 * x);

% 2. Generování dat
n = 20;                                % Počet vzorkovacích bodů
x = linspace(0, 2*pi, n)';             % Rovnoměrně rozložené body
y_true = f(x);                         % Hodnoty bez šumu
noise = 0.1 * randn(size(x));         % Náhodný šum (normalizovaný)
y = y_true + noise;                   % Šumová data (měřená)

% 3. Aproximace pomocí polynomu
degree = 7;                            % Zvolit stupeň polynomu
p = polyfit(x, y, degree);            % Koeficienty polynomu
x_dense = linspace(0, 2*pi, 1000)';   % Hustší síť pro hladkou křivku
y_fit = polyval(p, x_dense);          % Aproximovaná křivka
y_true_dense = f(x_dense);            % Skutečná hodnota pro srovnání

% 4. Vyhodnocení výsledku
rmse = sqrt(mean((polyval(p, x) - y_true).^2));  % RMSE na trénovacích bodech
fprintf('RMSE pro polynom stupně %d: %.4f\n', degree, rmse);

% 5. Vykreslení výsledků
figure;
plot(x, y, 'bo', 'MarkerSize', 8, 'DisplayName', 'Noisy data'); hold on;
plot(x_dense, y_fit, 'r-', 'LineWidth', 2, 'DisplayName', 'Polynomial fit');
plot(x_dense, y_true_dense, 'g--', 'LineWidth', 2, 'DisplayName', 'True function');
legend('Location', 'best');
xlabel('x'); ylabel('y');
title(sprintf('Polynomiální fit (stupeň %d), RMSE = %.4f', degree, rmse));
grid on;
