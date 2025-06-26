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
plot(s, y_exact, 'k', 'LineWidth', 2); hold on;
plot(s, y, 'm--', 'LineWidth', 2);
title('Aproximace funkce sin(x) * cos(3x)');
xlabel('x');
ylabel('p(x)');
legend('f(x)', 'Approximace', 'Location', 'best');
grid on;

% Grafické zobrazení chyby
subplot(2,1,2);
semilogy(s, error, 'r', 'LineWidth', 2);
title('Aproximační chyba');
xlabel('x');
ylabel('||p(x) - f(x)||');
grid on;

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
semilogy(n_values, errors, 'b', 'LineWidth', 2);
xlabel('Stupeň polynomu n');
ylabel('||p(x) - f(x)||_2');
title('Závislost aproximační chyby na stupni polynomu');
grid on;
