function PlotGaussians(X, y, M, title_string, nfig)
    % Add data for gaussian cluster to the cell array D
    for i = 1 : M
        q = y == i - 1;
        D{i} = X(q, :);
    end
    
    figure(nfig)
    scatter(D{1}(:, 1), D{1}(:, 2), 'bo','MarkerFaceAlpha',.5);
    hold on
    scatter(D{2}(:, 1), D{2}(:, 2), 'rx','MarkerFaceAlpha',.5);

    % add gaussian cluster centroids to the plot
    for i = 1 : M
        hold on
        plot(mean(D{i}(:, 1)), mean(D{i}(:, 2)), '*K','MarkerSize', 10, 'LineWidth', 2);
    end
    hold('off')


    xlabel('x_1');
    ylabel('x_2');
    title(title_string);
end
