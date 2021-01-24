load compEx1Data.mat
scatter3(X(1,:), X(2,:), X(3,:))
axis equal
hold on
plotcams(P);

%%
for i = 1:9
    im = imread(imfiles{i});
    figure
    imshow(im)
    hold on
    flat = pflat(P{i}*X);
    visible = isfinite(flat(3,:));
    scatter(flat(1,visible), flat(2,visible))
end

%%