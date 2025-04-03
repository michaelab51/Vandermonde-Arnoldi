function c = polyfit(x, f, n)
    A = x .^ (0:n);
    c = A \ f;
end

function y = polyval(c, s)
    n = length(c) - 1;
    B = s .^ (0:n);
    y = B * c;
end

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

% Grafické zobrazení
figure;
subplot(2,1,1);
plot(s, y, 'b', 'LineWidth', 2);
title('Aproximace funkce sign(x)');
xlabel('x');
ylabel('p(x)');
grid on;

%Grafické zobrazení chyby
subplot(2,1,2);
semilogy(s, error, 'r', 'LineWidth', 2);
xlim([0 1]);
title('Aproximační chyba');
xlabel('x');
ylabel('|p(x) - sign(x)|');
grid on;
