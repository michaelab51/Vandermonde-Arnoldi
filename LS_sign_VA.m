function [d,H] = polyfitA(x, f, n)
    m = length(x);
    Q = ones(m,1);
    H = zeros(n+1, n);
    for k = 1:n
        q = x .* Q(:,k);
        for j = 1:k
            H(j,k) = (Q(:,j)' * q) / m;
            q = q - H(j,k) * Q(:,j);
        end
        H(k+1,k) = norm(q) / sqrt(m);
        Q = [Q q / H(k+1,k)];
    end
    d = Q \ f;
end

function y = polyvalA(d, H, s)
    M = length(s);
    W = ones(M,1);
    n = size(H,2);
    for k = 1:n
        w = s .* W(:,k);
        for j = 1:k
            w = w - H(j,k) * W(:,j);
        end
        W = [W w / H(k+1,k)];
    end
    y = W * d;
end

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