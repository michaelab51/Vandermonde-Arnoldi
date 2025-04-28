% Diskretizace domény
x1 = linspace(-1, -1/3, 500)';
x2 = linspace(1/3, 1, 500)';
x = [x1; x2];


f = sign(x);
n = 80;

% LS
[d, H] = polyfitA(x, f, n);

% Evaluace hledaného polynomu
s = linspace(-1, 1, 1000)';
y = polyvalA(d, H, s);

% Výpočet chyby
y_exact = sign(s);
error = abs(y - y_exact);

% Grafické zobrazení
figure;
subplot(2,1,1);
plot(s, sign(x), 'k', 'LineWidth', 3); hold on;
plot(s, y, 'g--', 'LineWidth', 3);
title('Aproximace funkce sign(x)');
xlabel('x');
ylabel('p(x)');
legend('sign(x)', 'Approximace');
grid on;

%Grafické zobrazení chyby
subplot(2,1,2);
semilogy(s, error, 'r', 'LineWidth', 3);
xlim([0 1]);
title('Aproximační chyba');
xlabel('x');
ylabel('||p(x) - sign(x)||_2');
grid on;

n_values = 1:200;
errors = zeros(size(n_values));

for idx = 1:length(n_values)
    n = n_values(idx);
    [d, H] = polyfitA(x, f, n);
    
    % Rekonstrukce Q pomocí stejné rekurence (alternativně lze i Q uložit)
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

% Vykreslení chyby
figure;
semilogy(n_values, errors, 'b', 'LineWidth', 3);
xlabel('Stupeň polynomu n');
ylabel('||p(x)-sign(x)||_2');
title('Závislost aproximační chyby na stupni polynomu');
grid on;
