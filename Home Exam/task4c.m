clear
close all
restoredefaultpath
addpath('data2020')
load('ex4data.mat')

%% Remove indices containing NaN in x1:
idx_no_nan = ~isnan(x{1});
x1_without_nan = x{1}(idx_no_nan);
x1_without_nan = reshape(x1_without_nan, [3, length(x1_without_nan)/3]);
X1 = X([idx_no_nan; idx_no_nan(3,:)]);
X1 = reshape(X1, [4, length(X1)/4]);

%% Remove indices containing NaN in x2:
idx_no_nan = ~isnan(x{2});
x2_without_nan = x{2}(idx_no_nan);
x2_without_nan = reshape(x2_without_nan, [3, length(x2_without_nan)/3]);
X2 = X([idx_no_nan; idx_no_nan(3,:)]);
X2 = reshape(X2, [4, length(X2)/4]);

%% Normalization
% x1
mu1 = mean(x1_without_nan, 2);
sigma1 = std(x1_without_nan');

N1 = [1/sigma1(1) 0 -(1/sigma1(1))*mu1(1);
    0 1/sigma1(2) -(1/sigma1(2))*mu1(2);
    0 0 1];

x1_hat = N1*x1_without_nan;

% x2
mu2 = mean(x2_without_nan, 2);
sigma2 = std(x2_without_nan');

N2 = [1/sigma2(1) 0 -(1/sigma2(1))*mu2(1);
    0 1/sigma2(2) -(1/sigma2(2))*mu2(2);
    0 0 1];

x2_hat = N2*x2_without_nan;

%% DLT resectioning - Finding P1
% For 31 iterations:
%   Pick 6 random points
%   Calculate the best P
% Choose the best P.

num_correspondences = 6;
best_P = 0;
best_outiers = inf;
for j = 1:31
    % Get index for 6 random points
    idx = randperm(length(X1(1,:)),num_correspondences);
    % Pick those points corresponding to the index
    X_RANSAC = X1(:,idx);
    x1_RANSAC = x1_hat(:,idx);
    
    % Create M
    M = zeros(3*num_correspondences,12+num_correspondences);
    for i = 1:3:3*num_correspondences
        index = floor(i/3) + 1;
        M(i,1:4) = X_RANSAC(:, index)';
        M(i + 1,5:8) = X_RANSAC(:, index)'; 
        M(i + 2,9:12) = X_RANSAC(:, index)'; 
        M(i:i+2,12 + index) = -x1_RANSAC(:, index);
    end
    [U,S,V] = svd(M);
    % Pick v corresponding to smallest eigenvalue for best match
    v = -V(:,end);
    % Compare to other Ransac-iterations
    P_hat = [v(1:4)';v(5:8)';v(9:12)'];
    proj = pflat(N1\P_hat*X1);
    outliers = sum(vecnorm(x1_without_nan-proj) > 15);
    if outliers < best_outiers
        best_outiers = outliers;
        best_P = P_hat;
    end
end

P1 = N1\best_P;
C1 = pflat(null(P1));
cam_dir_1 = P1(3,1:3)/norm(P1(3,1:3));

%% DLT resectioning - Finding P2
% For 31 iterations:
%   Pick 6 random points
%   Calculate the best P
% Choose the best P.

num_correspondences = 6;
best_P = 0;
best_outiers = inf;
for j = 1:31
    % Get index for 6 random points
    idx = randperm(length(X2(1,:)),num_correspondences);
    % Pick those points corresponding to the index
    X_RANSAC = X2(:,idx);
    x2_RANSAC = x2_hat(:,idx);
    
    % Create M
    M = zeros(3*num_correspondences,12+num_correspondences);
    for i = 1:3:3*num_correspondences
        index = floor(i/3) + 1;
        M(i,1:4) = X_RANSAC(:, index)';
        M(i + 1,5:8) = X_RANSAC(:, index)'; 
        M(i + 2,9:12) = X_RANSAC(:, index)'; 
        M(i:i+2,12 + index) = -x2_RANSAC(:, index);
    end
    [U,S,V] = svd(M);
    % Pick v corresponding to smallest eigenvalue for best match
    v = -V(:,end);
    % Pick the solution with lambads in v > 0
    if v(13) < 0
        v = -v;
    end
    
    % Compare to other Ransac-iterations
    P_hat = [v(1:4)';v(5:8)';v(9:12)'];
    proj = pflat(N2\P_hat*X2);
    outliers = sum(vecnorm(x2_without_nan-proj) > 15);
    if outliers < best_outiers
        best_outiers = outliers;
        best_P = P_hat;
    end
end

P2 = N2\best_P;
C2 = pflat(null(P2));
cam_dir_2 = P2(3,1:3)/norm(P2(3,1:3));

%% Some plots
scatter3(X(1,:),X(2,:),X(3,:))
hold on
scatter3(C1(1),C1(2),C1(3),100)
scatter3(C2(1),C2(2),C2(3),100)

quiver3(C1(1),C1(2),C1(3), cam_dir_1(1),cam_dir_1(2),cam_dir_1(3), 20);
quiver3(C2(1),C2(2),C2(3), cam_dir_2(1),cam_dir_2(2),cam_dir_2(3), 20);


%%

%{
%% Some extra plots that I used to check my result 
%% Only plot points that has not been affected as much by the distortion
proj = P1*X1;
%img_pts = pflat(proj(:, abs(proj(3,:)) > 0.15));
img_pts = pflat(P1*X1);
correct = vecnorm(img_pts - x1_without_nan) < 10;
figure
axis equal
hold on
scatter(img_pts(1,correct), img_pts(2,correct))
scatter(x1_without_nan(1,correct), x1_without_nan(2,correct), 'x')
hold off


%% All projected points (distorted), can't really see much
figure
axis equal
hold on
scatter(img_pts(1,:), img_pts(2,:))
scatter(x1_without_nan(1,:), x1_without_nan(2,:), 'x')
hold off

%}


