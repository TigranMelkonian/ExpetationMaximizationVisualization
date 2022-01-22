function [X,Y_groundTruth] = GenerateRandomGMM()
    fprintf('========== Randomly generating GMM, where M = 2 ==========\n');
    global M; % mixtur of M Gaussians, M is assumed to be known
    M = 2;
    
    % GMM will contain 1000 points in total
    npt1 = randi([250 750]); %randomly determin number of pts for first gaussian
    
    npt2 = 1000 - npt1; % determine number of pts for second gaussian given npt1
    n = [npt1 npt2]; % number of data points (per gaussian)
    
    m1 = randi([0 10]);
    m2 = randi([0 10]);
    m3 = randi([0 10]);
    m4 = randi([0 10]);
    m = [[m1 m2]' [m3 m4]'];% true means
    fprintf('Randomly generated true means:\n');
    fprintf("%d %d\n",m');
    
    s1 = round(rand(1,1),2);
    s2 = round(rand(1,1),2);
    s3 = round(rand(1,1),2);
    s4 = round(rand(1,1),2);
    S(:, :, 1) = [1 s1;s2 1]; % true covariance matrices
    S(:, :, 2) = [1 s3; s4 1];
    fprintf('Randomly generated true covariance matrices:\n');
    fprintf("%.2f %.2f\n",S(:, :, 1)');
    fprintf("\n");
    fprintf("%.2f %.2f\n",S(:, :, 2)');
    X = [];
    Y_groundTruth = [];
    for k = 1 : M
        X = [X; repmat(m(:, k)', n(k), 1) + randn(n(k), 2) * chol(S(:, :, k))];
        Y_groundTruth = [Y_groundTruth; (k - 1) * ones(n(k), 1)];
    end
end