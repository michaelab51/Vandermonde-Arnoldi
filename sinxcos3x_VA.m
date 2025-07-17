addpath('Funkce');

% Generování dat
x = linspace(-pi, pi, 1000)';
f = sin(x) .* cos(3*x);  % cílová funkce
n = 30;                  % stupeň polynomu

% Aproximace
[d, H] = polyfitA(x, f, n);

% Vyhodnocení
s = linspace(-pi, pi, 1000)';
y = polyvalA(d, H, s);
y_exact = sin(s) .* cos(3*s);
error = abs(y - y_exact);

% Graf výsledků
figure;
subplot(2,1,1);
plot(s, y_exact, 'k', 'LineWidth', 3); hold on;
plot(s, y, 'm--', 'LineWidth', 3);
title('Aproximace funkce sin(x)cos(3x)', 'FontSize', 16);
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

% Závislost chyby na stupni n
n_values = 1:40;
errors = zeros(size(n_values));
for idx = 1:length(n_values)
    n = n_values(idx);
    [d, H] = polyfitA(x, f, n);

    m = length(x);
    Q = ones(m,1);
    for k = 1:n
        q = x .* Q(:,k);
        for j = 1:k
            q = q - H(j,k) * Q(:,j);
        end
        q = q / H(k+1,k);
        Q = [Q q];
    end

    f_approx = Q * d;
    errors(idx) = norm(f - f_approx, 2);
end

% Graf závislosti chyby na n
figure;
semilogy(n_values, errors, 'b', 'LineWidth', 3);
xlabel('Stupeň polynomu n');
ylabel('||p(x) - f(x)||_2');
title('Závislost chyby aproximace na stupni polynomu');
grid on;
