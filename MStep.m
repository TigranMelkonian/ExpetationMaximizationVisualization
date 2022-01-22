function [w, mu, sg] = MStep(X, w, mu, py)
    global M;
    global K;
    % Given newly calculated py, update parameters w, mu, and sg
    sg = zeros(K, K, M);
    for k = 1 : M
        w(k) = mean(py(:, k), 1);
        mu(:, k) = zeros(K, 1);
        for i = 1 : size(X, 1)
            mu(:, k) = mu(:, k) + py(i, k) * X(i, :)';
        end
        mu(:, k) = mu(:, k) / sum(py(:, k), 1);

        for i = 1 : size(X, 1)
            sg(:, :, k) = sg(:, :, k) + py(i, k) * (X(i, :)' - mu(:, k)) * (X(i, :)' - mu(:, k))';
        end
        sg(:, :, k) = sg(:, :, k) / sum(py(:, k), 1);
    end

end