function mu = RunEM()
    clear all;
    global M;
    
    % Generate two random gaussians x_1, x_2 -> X 
    % and assign Y_groundTruth to each respcetive group
    [X,Y_groundTruth] = GenerateRandomGMM();
    
    % Visualize true data
    PlotGaussians(X, Y_groundTruth, M, 'Ground Truth Data', 1)
    fprintf('Please hit [enter] to proceed ..\n');
    pause

    % EM algorithm
    [w,mu, sg] = EM(X, M);
    fprintf('Estimated means:\n');
    fprintf("%.2f %.2f\n",mu');
end
