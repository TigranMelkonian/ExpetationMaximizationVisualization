function [w, mu, sg] = EM(X, M)
    fprintf('========== Starting EM Evaluation ==========\n');
    
    tol = 1e-12; % iterative diff tolerance level
    max_step = 200; % maximum number of iterations
    
    global K;
    K = size(X, 2); % dimensionality of the sample

    % initialize w, mu, and sg
    w = ones(1, M)* rand(1,1) / M;

    d = 0.01 * mean(sum((X - repmat(mean(X, 1), size(X, 1), 1)).^ 2, 2));
    % initial centroids, using the splitting method
    mu = [mean(X, 1)' mean(X, 1)' + d * sign(randn(1, K))']; 

    for m = 1 : M
        sg(:, :, m) = diag(ones(K, 1));
    end

    step = 0;
    diff = 2 * tol; % just to ensure it is greater than tol

    while diff > tol && step < max_step
        % Initialize parameters for current time step
        w_t = w;
        mu_t = mu;
        sg_t = sg;
        
        % E-Step
        py = EStep(X,w,mu,sg);
        
        % M-Step
        sg = zeros(K, K, M);
        [w,mu,sg] = MStep(X,w,mu,py);
        
        % visualize Gaussian clusters after E & M step
        [~, y] = max(py, [], 2); % get best cluster for each data point
        PlotGaussians(X, y - 1, size(py, 2), sprintf('Current EM Interation: %0.0f',step), 2);
        
        if step == 0
            fprintf('Please hit [enter] to proceed ..\n');
            pause;
        else
            pause(.1);
        end

        diff = sum(abs(w - w_t)) + sum(abs(mu - mu_t),'all') + sum(abs(sg - sg_t), 'all');
        step = step + 1;
    end
    [~, y] = max(py, [], 2);
    title_string = sprintf('Current EM Interation: %0.0f',step);
    PlotGaussians(X, y - 1, size(py, 2), title_string, 2);
    fprintf('========== Finished EM Evaluation ==========\n');
end
