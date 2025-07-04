% Generování Čebyševových uzlů
n = 80;
j = (0:n)';
x = cos(j * pi / n);

% Cílová funkce
f = 1 ./ (1 + 25 * x.^2);

% Interpolace pomocí polynomu
c = polyfit(x, f, n);

% Evaluace výsledného polynomu
s = linspace(-1, 1, 1000)';
y = polyval(c, s);

% Výpočet skutečné funkční hodnoty
y_exact = 1 ./ (1 + 25 * s.^2);
error = abs(y - y_exact);

% Grafické zobrazení
figure;
subplot(2,1,1);
plot(s, y_exact, 'k', 'LineWidth', 3); hold on;
plot(s, y, 'g--', 'LineWidth', 3);
title('Interpolace v Čebyševových bodech', 'FontSize', 16);
xlabel('x', 'FontSize', 14);
ylabel('p(x)', 'FontSize', 14);
legend('Funkce', 'Aproximace', 'FontSize', 12);
grid on;
set(gca, 'FontSize', 12);

subplot(2,1,2);
semilogy(s, error, 'r', 'LineWidth', 3);
xlim([-1 1]);
title('Interpolační chyba', 'FontSize', 16);
xlabel('x', 'FontSize', 14);
ylabel('||p(x) - f(x)||_2', 'FontSize', 14);
grid on;
set(gca, 'FontSize', 12);

% Rozsah stupňů polynomu
n_values = 1:200;
errors = zeros(size(n_values));

for idx = 1:length(n_values)
    n = n_values(idx);

    % Sestavení Vandermondeovy matice
    A = x .^ (0:n);

    % Výpočet koeficientů metodou nejmenších čtverců
    c = A \ f;

    % Výpočet aproximace
    f_approx = A * c;

    % Výpočet chyby v 2-normě
    errors(idx) = norm(f - f_approx, 2);
end

% Vykreslení grafu chyby
figure;
semilogy(n_values, errors, 'b', 'LineWidth', 3);
xlabel('Stupeň polynomu n', 'FontSize', 14);
ylabel('||p(x) - f(x)||_2', 'FontSize', 14);
title('Závislost aproximační chyby na stupni polynomu', 'FontSize', 16);
grid on;
set(gca, 'FontSize', 12);
