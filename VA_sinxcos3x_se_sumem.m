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

% Generování dat
n = 50;
x = linspace(0, 2*pi, n)';
f_true = sin(x) .* cos(3*x);
noise = 0.1 * randn(size(x));        % náhodný šum
f_noisy = f_true + noise;            % data s šumem

% Aproximace pomocí polynomu
degree = 10;
[d, H] = polyfitA(x, f_noisy, degree);

% Evaluace polynomu
s = linspace(0, 2*pi, 1000)';
y_fit = polyvalA(d, H, s);
y_exact = sin(s) .* cos(3*s);

% Výpočet RMSE
rmse = sqrt(mean((polyvalA(d, H, x) - f_true).^2));

% Vykreslení výsledků
figure;
plot(x, f_noisy, 'bo', 'DisplayName', 'Noisy data'); hold on;
plot(s, y_fit, 'r-', 'LineWidth', 2, 'DisplayName', 'Polynomial fit');
plot(s, y_exact, 'g--', 'LineWidth', 2, 'DisplayName', 'True function');
legend('Location', 'best');
title(['Aproximace funkce sin(x)cos(3x), n = ', num2str(degree), ', RMSE = ', num2str(rmse)]);
xlabel('x'); ylabel('y');
grid on;

% Porovnání chyb pro různé stupně - dávat?
n_values = 1:40;
errors = zeros(size(n_values));
for idx = 1:length(n_values)
    n = n_values(idx);
    [d, H] = polyfitA(x, f_noisy, n);

    % Znovu sestavit bázi Q
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
    errors(idx) = sqrt(mean((f_approx - f_true).^2)); % RMSE oproti přesné hodnotě
end

figure;
semilogy(n_values, errors, 'b', 'LineWidth', 2);
xlabel('Stupeň polynomu n');
ylabel('RMSE');
title('Závislost RMSE na stupni polynomu');
grid on;
