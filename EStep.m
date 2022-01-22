function py = EStep(X, w, mu, sg)
    global M;
    global K;
    % Given current w, mu, and sg, update "class posterior probabilities" py
    for i = 1 : size(X, 1)
        Z = 0;
        for k = 1 : M
            t = X(i, :)' - mu(:, k);
            Z = Z + w(k) / sqrt((2*pi) ^ K * det(sg(:, :, k))) * exp(-0.5 * (t') / (sg(:, :, k)) * t);
        end
        for k = 1 : M
            t = X(i, :)' - mu(:, k);
            py(i, k) = w(k) / sqrt((2*pi) ^ K * det(sg(:, :, k))) * exp(-0.5 * (t') / (sg(:, :, k)) * t) / Z;
        end
    end
end
