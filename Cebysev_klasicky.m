function c = polyfit(x, f, n)
    A = x .^ (0:n);
    c = A \ f;
end

function y = polyval(c, s)
    n = length(c) - 1;
    B = s .^ (0:n);
    y = B * c;
end

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
plot(s, y_exact, 'k', 'LineWidth', 2); hold on;
plot(s, y, 'g--', 'LineWidth', 2);
title('Interpolace v Čebyševových bodech');
xlabel('x');
ylabel('p(x)');
legend('Funkce', 'Interpolant');
grid on;

%Grafické zobrazení chyby
subplot(2,1,2);
semilogy(s, error, 'r', 'LineWidth', 2);
xlim([0 1]);
title('Interpolační chyba');
xlabel('x');
ylabel('|p(x) - f(x)|');
grid on;
