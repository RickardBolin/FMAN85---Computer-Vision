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
