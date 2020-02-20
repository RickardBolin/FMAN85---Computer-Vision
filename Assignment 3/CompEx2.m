clear
close all
restoredefaultpath
addpath('assignment3data')
load ex1.mat
kron1 = imread('kronan1.JPG');
kron2 = imread('kronan2.JPG');

e2 = null(F'); 
Pa = [eye(3,3), zeros(3,1)];
Pb = [[0, -e2(3), e2(2); 
       e2(3),0,-e2(1);
       -e2(2),e2(1),0]*F,e2];
   
x1 = N1*x1;
x2 = N2*x2;

X = zeros(4,length(x1));
for i = 1:length(x1)
   M = [Pa, -x1(:,i), [0; 0; 0] ; Pb, [0; 0; 0], -x2(:,i)];
   [U,S,V] = svd(M);
   v = V(:,end);
   X(:,i) = v(1:4);
end

X = pflat(X);

xproj1 = pflat( Pa * X );
xproj2 = pflat( Pb * X );
good_points = ( sqrt( sum(( x1 - xproj1).^2)) < 3 & ...
sqrt( sum(( x2 - xproj2).^2)) < 3);

figure
axis equal
scatter3(X(1,good_points), X(2,good_points), X(3,good_points));


% figure
% imshow(kron1)
% hold on
% scatter(xproj1(1,:), xproj1(2,:))
% hold on
% scatter(x1(1,:), x1(2,:), 'rx');
% hold off
% 
% figure
% imshow(kron2)
% hold on
% scatter(xproj2(1,:), xproj2(2,:))
% scatter(x2(1,:), x2(2,:), 'rx');
% hold off