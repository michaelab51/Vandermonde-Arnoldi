function c = polyfit(x, f, n)
    A = x .^ (0:n);
    c = A \ f;
end

function y = polyval(c, s)
    n = length(c) - 1;
    B = s .^ (0:n);
    y = B * c;
end

% Cílová funkce: sin(x) * cos(3x)
f = @(x) sin(x) .* cos(3 * x);

% 2. Generování dat
n = 20;        
x = linspace(0, 2*pi, 1000)';
y_true = f(x);
noise = 0.1 * randn(size(x));         % Náhodný šum
y = y_true + noise;                   % Šumová data

% 3. Aproximace pomocí polynomu
degree = 7; 
p = polyfit(x, y, degree);
x_dense = linspace(0, 2*pi, 1000)';
y_fit = polyval(p, x_dense);
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
