clear
close all
restoredefaultpath
addpath('assignment4data')
load('compEx1data.mat')

house1 = imread('house1.jpg');
house2 = imread('house2.jpg');
P1 = P{1}; P2 = P{2};
X = pflat(X);

%% rms fit på vanliga punkter
figure;
scatter3(X(1,:),X(2,:),X(3,:));
hold on;

RMS = @(plane) sqrt ( sum (( plane'* X ).^2)/ size (X ,2));
plane = fminsearch(RMS, [1 1 1 1]');
RMS(plane) % =  2.1710e-06

syms xx yy
z = -(plane(1)*xx+plane(2)*yy+plane(4))/plane(3);
fmesh(z)

%%
distances = abs (plane' * X);
histogram(distances,100);

%% ransac
figure;
scatter3(X(1,:),X(2,:),X(3,:));
hold on;
[plane, n_inliers, bestInlierIdx] = ransac(X,3,1000,0.1,0.5); %n_inliers = 740
RMS(plane) % = 0.5648

syms xx yy
z = -(plane(1)*xx+plane(2)*yy+plane(4))/plane(3);
fmesh(z)
hold on;

%%
distances = abs (plane' * X);
histogram(distances,100);

%% rms fit på inliers
figure;
scatter3(X(1,:),X(2,:),X(3,:));
hold on;

inliers = X(:,bestInlierIdx);
RMS2 = @(plane) sqrt ( sum (( plane'* inliers ).^2)/ size (inliers ,2));
plane = fminsearch(RMS2, [1 1 1 1]');
RMS2(plane) % =  2.1710e-06

syms xx yy
z = -(plane(1)*xx+plane(2)*yy+plane(4))/plane(3);
fmesh(z)
hold on;

%%
distances = abs (plane' * X);
histogram(distances,100);

%% plotting inliers in pic1
projected_inliers = P1*inliers;
projected_inliers = pflat(projected_inliers);
figure;
imshow(house1)
hold on;
scatter(projected_inliers(1,:),projected_inliers(2,:),'r')

%% plotting inliers in pic2
projected_inliers = P2*inliers;
projected_inliers = pflat(projected_inliers);
figure;
imshow(house2)
hold on;
scatter(projected_inliers(1,:),projected_inliers(2,:),'r')

%% plotting x in pic
P1kalib = K\P1;
P2kalib = K\P2;
xk = K\x;
pi = pflat(plane);
H = P2kalib(:,1:3) - (P2kalib(:,4)*pi(1:3)');
x2 = H*xk;
x2 = pflat(K*x2);

figure;
subplot(1, 2, 1);
imshow(house1)
hold on;
scatter(x(1,:),x(2,:),'r')
subplot(1, 2, 2);
imshow(house2)
hold on;
scatter(x2(1,:),x2(2,:),'r')

