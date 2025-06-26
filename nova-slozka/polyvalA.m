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
