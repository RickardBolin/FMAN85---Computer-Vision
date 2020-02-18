clear
close all
restoredefaultpath
addpath('assignment3data')
load compEx3data.mat
load compEx1data.mat
kron1 = imread('kronan1.JPG');
kron2 = imread('kronan2.JPG');
load ex3.mat

x1 = K\x{1};
x2 = K\x{2};

Pa = [eye(3) zeros(3,1)];
[U,S,V] = svd(E);
W = [0 -1 0; 1 0 0; 0 0 1];
Pb = [U*W'*V' -U(:,3)];

b1 = pflat(null(Pa));
n1 = Pa(3,1:3)/norm(Pa(3,1:3));
b2 = pflat(null(Pb));
n2 = Pb(3,1:3)/norm(Pb(3,1:3));


X = zeros(4,length(x1));
for i = 1:length(x1)
   M = [Pa, -x1(:,i), [0; 0; 0]; Pb, [0; 0; 0], -x2(:,i)];
   [U,S,V] = svd(M);
   v = V(:,end);
   X(:,i) = v(1:4);
end

X = pflat(X);

xproj1 = pflat(K*Pa * X );
xproj2 = pflat(K*Pb * X );

x1 = pflat(K*x1);
x2 = pflat(K*x2);


good_points = ( sqrt( sum(( x1(1:2 ,:) - xproj1(1:2 ,:)).^2)) < 3 & ...
sqrt( sum(( x2(1:2 ,:) - xproj2(1:2 ,:)).^2)) < 3);

figure
scatter3(X(1,good_points),X(2,good_points),X(3,good_points))
hold on
scatter3(b1(1),b1(2),b1(3))
quiver3(b1(1),b1(2),b1(3),n1(1),n1(2),n1(3),1/norm(n1));
scatter3(b2(1),b2(2),b2(3))
quiver3(b2(1),b2(2),b2(3),n2(1),n2(2),n2(3),1/norm(n2));
hold off

figure
imshow(kron1)
hold on
scatter(x1(1,good_points), x1(2,good_points))
scatter(xproj1(1,good_points),xproj1(2,good_points),'x')
hold off

figure
imshow(kron2)
hold on
scatter(x2(1,good_points), x2(2,good_points))
scatter(xproj2(1,good_points),xproj2(2,good_points),'x')
hold off
