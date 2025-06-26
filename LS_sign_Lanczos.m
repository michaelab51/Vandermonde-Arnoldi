% Diskretizace domény pro least squares problém
n = 80;
x1 = linspace(-1, -1/3, 500)';
x2 = linspace(1/3, 1, 500)';
x = [x1; x2];

% Cílová funkce
f = sign(x);

% Aproximace pomocí Lanczosova algoritmu
[c, T] = polyfitA(x, f, n);

% Evaluace výsledného polynomu
s = linspace(-1, 1, 1000)';
y = polyvalA(c, T, s);

% Výpočet skutečné hodnoty funkce sign(x)
sign_x = sign(s);
error = abs(y - sign_x);

% Grafické zobrazení
figure;
subplot(2,1,1);
plot(s, sign_x, 'k', 'LineWidth', 3); hold on;
plot(s, y, 'm--', 'LineWidth', 3);
title('Aproximace funkce sign(x) (Lanczos)');
xlabel('x');
ylabel('p(x)');
legend('sign(x)', 'Approximace');
grid on;

subplot(2,1,2);
plot(s, error, 'r', 'LineWidth', 3);
xlim([0 1]);
title('Aproximační chyba');
xlabel('x');
ylabel('||p(x) - sign(x)||_2');
grid on;
