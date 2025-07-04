% Diskretizace domény
x1 = linspace(-1, -1/3, 500)';
x2 = linspace(1/3, 1, 500)';
x = [x1; x2];

% Cílová funkce
f = sign(x);

% Stupeň polynomu
n = 80;

% Least-squares fit
c = polyfit(x, f, n);

% Evaluace výsledného polynomu
s = linspace(-1, 1, 1000)';
y = polyval(c, s);

% Výpočet chyby
y_exact = sign(s);
error = abs(y - y_exact);

%grafy
figure;
subplot(2,1,1);
plot(s, sign(x), 'k', 'LineWidth', 3); hold on;
plot(s, y, 'm--', 'LineWidth', 3);
title('Aproximace funkce sign(x)', 'FontSize', 16);
xlabel('x', 'FontSize', 14);
ylabel('p(x)', 'FontSize', 14);
legend('sign(x)', 'Approximace', 'Location', 'southeast', 'FontSize', 12);
grid on;
set(gca, 'FontSize', 12);

subplot(2,1,2);
semilogy(s, error, 'r', 'LineWidth', 3);
xlim([-1 1]);
title('Aproximační chyba', 'FontSize', 16);
xlabel('x', 'FontSize', 14);
ylabel('||p(x) - sign(x)||_2', 'FontSize', 14);
grid on;
set(gca, 'FontSize', 12);


%Závislost chyby na n
n_values = 1:200;
errors = zeros(size(n_values));

for idx = 1:length(n_values)
    n = n_values(idx);
    A = x .^ (0:n);
    c = A \ f;
    f_approx = A * c;
    errors(idx) = norm(f - f_approx, 2);
end

figure;
semilogy(n_values, errors, 'b', 'LineWidth', 3);
xlabel('Stupeň polynomu n', 'FontSize', 14);
ylabel('||p(x) - sign(x)||_2', 'FontSize', 14);
title('Závislost aproximační chyby na stupni polynomu', 'FontSize', 16);
grid on;
set(gca, 'FontSize', 12);

