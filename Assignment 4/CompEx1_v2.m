clear
close all
restoredefaultpath
addpath('assignment4data')
load('compEx1data.mat')

house1 = imread('house1.jpg');
house2 = imread('house2.jpg');
P1 = P{1}; P2 = P{2};
X = pflat(X);


TLS = @(plane) sum( sqrt((plane'*X).^2)./sqrt(sum(plane(1:3).^2)) );
distances = @(plane) sqrt((plane'*X).^2)./sqrt(sum(plane(1:3).^2));
eRMS = @(plane) sqrt( mean( ((plane'*X).^2)./sum(plane(1:3).^2) ) );
syms xx yy
z = @(plane) -(plane(1)*xx + plane(2)*yy + plane(4))/plane(3);

TLSplane = fminsearch(TLS, [1 1 1 1]');

figure
scatter3(X(1,:), X(2,:), X(3,:))
hold on
fmesh(z(TLSplane))
hold off

RMSdist1 = eRMS(TLSplane)

ransacIter = 1000;
inliners = zeros(1,ransacIter);
ransacPlanes = zeros(4,ransacIter);

for iter = 1:ransacIter
    perm = randperm(length(X));
    set = X(:,perm(1:3));
    R = set(1:3,2) - set(1:3,1);
    Q = set(1:3,3) - set(1:3,1);
    normal = cross(R,Q);
    normal = normal./norm(normal);
    d = -normal'*X(1:3,1);
    ransacPlanes(:, iter) = [normal; d];
    inliners(:,iter) = sum(distances(ransacPlanes(:,iter)) < 0.1); 
end
bestiter = find(max(inliners) == inliners);
if size(bestiter,2) > 1
    bestiter = bestiter(1);
end
ransacPlane = ransacPlanes(:,bestiter);


figure
scatter3(X(1,:), X(2,:), X(3,:))
hold on
fmesh(z(ransacPlane))
hold off

RMSdist2 = eRMS(ransacPlane)

figure
histogram(distances(ransacPlane), 100)

inliners = distances(ransacPlane) < 0.1;

iX = X(:,inliners);

TLSspecial= @(plane) sum( sqrt((plane'*iX).^2)./sqrt(sum(plane(1:3).^2)) );

iTLSplane = fminsearch(TLSspecial, [1 1 1 1]');

figure
scatter3(X(1,:), X(2,:), X(3,:))
hold on
fmesh(z(iTLSplane))
hold off

RMSdist3 = eRMS(iTLSplane)

figure
histogram(distances(iTLSplane), 100)
%%

projected_inliers = P1*iX;
projected_inliers = pflat(projected_inliers);
figure;
imshow(house1)
hold on;
scatter(projected_inliers(1,:),projected_inliers(2,:),'r')
hold off

projected_inliers = P2*iX;
projected_inliers = pflat(projected_inliers);
figure;
imshow(house2)
hold on;
scatter(projected_inliers(1,:),projected_inliers(2,:),'r')
hold off


%%
P1kalib = K\P1;
P2kalib = K\P2;
xk = K\x;
pi = pflat(iTLSplane);
pi = pi./norm(pi);
H = P2kalib(:,1:3) - (P2kalib(:,4)*pi(1:3)');
x2 = H*xk;
x2 = pflat(K*x2);

figure;
subplot(1, 2, 1);
imshow(house1)
hold on;
scatter(x(1,:),x(2,:),'r')
hold off
subplot(1, 2, 2);
imshow(house2)
hold on;
scatter(x2(1,:),x2(2,:),'r')
hold off
