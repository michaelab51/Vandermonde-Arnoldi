addpath('Funkce');

% Cílová funkce: sin(x) * cos(3x)
f = @(x) sin(x) .* cos(3 * x);

% 2. Generování dat
n = 100;               
x = linspace(-pi, pi, n)';            
y_true = f(x);                         
noise = 0.1 * randn(size(x));         
y = y_true + noise;                   

% 3. Aproximace pomocí polynomu
degree = 30;                        
p = polyfit(x, y, degree);      
x_dense = linspace(-pi, pi, 1000)';  
y_fit = polyval(p, x_dense);         
y_true_dense = f(x_dense);         

% 4. Vyhodnocení výsledku
rmse = sqrt(mean((polyval(p, x) - y_true).^2));  
fprintf('RMSE pro polynom stupně %d: %.4f\n', degree, rmse);

% Vykreslení výsledků
figure;
plot(x, y, 'bo', 'MarkerFaceColor', 'b', 'DisplayName', 'Data'); hold on;
plot(x_dense, y_true_dense, 'g-', 'LineWidth', 3, 'DisplayName', 'Pravá funkce');
plot(x_dense, y_fit, 'r--', 'LineWidth', 3, 'DisplayName', 'Aproximace');
legend('Location', 'southeast', 'FontSize', 12);
xlabel('x', 'FontSize', 14);
ylabel('p(x)', 'FontSize', 14);
title(['Aproximace funkce sin(x)cos(3x)'], 'FontSize', 16);
grid on;
set(gca, 'FontSize', 12);
