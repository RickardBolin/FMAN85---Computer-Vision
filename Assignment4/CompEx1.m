clear
close all
restoredefaultpath
addpath('assignment4data')
load('compEx1data.mat')

house1 = imread('house1.jpg');
house2 = imread('house2.jpg');

X = pflat(X);

rms = @(plane) mean(([plane 1]*[X(1:3,:); ones(1,length(X))]).^2)./(sum(plane(1:3).^2));
plane = fminsearch(rms, [1 1 1]);

% sampleSize = 2; % number of points to sample per trial
% maxDistance = 2; % max allowable distance for inliers
% 
% fitFcn = @(points) polyfit(points(:,1),points(:,2),1); % fit function using polyfit
% evalFcn = ...   % distance evaluation function
%   @(model, points) sum((points(:, 2) - polyval(model, points(:,1))).^2,2);
% 
% [modelRANSAC, inlierIdx] = ransac(points,fitFcn,evalFcn, sampleSize,maxDistance);

% Generate random data for test
ransac(X,3,1000,0.5,0.5);









