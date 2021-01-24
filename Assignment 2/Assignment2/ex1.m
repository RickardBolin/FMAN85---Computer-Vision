load compEx1data.mat
plotcams(P);
axis equal
hold on
scatter3(X(1,:),X(2,:),X(3,:))
%%

im = {};
for i = 1:9
    im{i} = imread(imfiles{i});
end

vis = isfinite(x{1}(1,:));
points = pflat(P{1}*X);
figure;
imshow(im{1})
hold on
scatter(points(1,vis), points(2,vis))
scatter(x{1}(1,:), x{1}(2,:), '.')


%%
T1 = [1 0 0 0; 0 4 0 0; 0 0 1 0; 0.1 0.1 0 1];
T2 = [1 0 0 0; 0 1 0 0; 0 0 1 0; 0.0625 0.0625 0 1];    

T1P = {};
T2P = {};
for i = 1:9
    T1P{i} = P{i}*T1;
    T2P{i} = P{i}*T2;
end
T1X = (T1\X);
T2X = (T2\X);

%%
figure;
T1points = pflat(T1P{1}*T1X);
imshow(im{1})
hold on
scatter(T1points(1,vis), T1points(2,vis), '.')
scatter(points(1,vis), points(2,vis))

%%
figure;
T2points = pflat(T2P{1}*T2X);
imshow(im{1})
hold on
scatter(T2points(1,vis), T2points(2,vis), '.')
scatter(points(1,vis), points(2,vis))



%%
figure
scatter3(T1X(1,:),T1X(2,:),T1X(3,:),'.')
axis equal
hold on
scatter3(X(1,:),X(2,:),X(3,:))
plotcams(P);
plotcams(T1P);
hold off
%%
figure
scatter3(T2X(1,:),T2X(2,:),T2X(3,:),'.')
axis equal
hold on
scatter3(X(1,:),X(2,:),X(3,:))
plotcams(P);
plotcams(T2P);
hold off


