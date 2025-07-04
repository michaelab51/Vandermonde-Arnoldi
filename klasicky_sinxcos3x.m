% Diskretizace domény
x = linspace(-pi, pi, 1000)';  % Husté body pro přesnou aproximaci

% Cílová funkce: sin(x) * cos(3x)
f = sin(x) .* cos(3 * x);

% Stupeň polynomu
n = 20;

% Least-squares fit
c = polyfit(x, f, n);

% Evaluace výsledného polynomu
s = linspace(-pi, pi, 1000)';
y = polyval(c, s);

% Výpočet chyby
y_exact = sin(s) .* cos(3 * s);
error = abs(y - y_exact);

% Grafické zobrazení
figure;
subplot(2,1,1);
plot(s, y_exact, 'k', 'LineWidth', 3); hold on;
plot(s, y, 'm--', 'LineWidth', 3);
title('Aproximace funkce sin(x)cos(3x)', 'FontSize', 16);
xlabel('x', 'FontSize', 14);
ylabel('p(x)', 'FontSize', 14);
legend('f(x)', 'Approximace', 'Location', 'best', 'FontSize', 12);
grid on;
set(gca, 'FontSize', 12);

subplot(2,1,2);
semilogy(s, error, 'r', 'LineWidth', 3);
xlim([-1 1]);
title('Aproximační chyba', 'FontSize', 16);
xlabel('x', 'FontSize', 14);
ylabel('||p(x) - f(x)||_2', 'FontSize', 14);
grid on;
set(gca, 'FontSize', 12);

% Závislost chyby na stupni polynomu
n_values = 1:80;
errors = zeros(size(n_values));

for idx = 1:length(n_values)
    n = n_values(idx);
    A = x .^ (0:n);
    c = A \ f;
    f_approx = A * c;
    errors(idx) = norm(f - f_approx, 2);  % 2-norma chyby
end

% Vykreslení chyby v závislosti na stupni
figure;
semilogy(n_values, errors, 'b', 'LineWidth', 3);
xlabel('Stupeň polynomu n', 'FontSize', 14);
ylabel('||p(x) - f(x)||_2', 'FontSize', 14);
title('Závislost aproximační chyby na stupni polynomu', 'FontSize', 16);
grid on;
set(gca, 'FontSize', 12);
