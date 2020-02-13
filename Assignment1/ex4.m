clear
close all
load compEx4.mat
im1 = imread('compEx4im1.jpg');
im2 = imread('compEx4im2.jpg');

b1 = pflat(null(P1));
b2 = pflat(null(P2));

pfU = pflat(U);

n1 = P1(3,1:3);
n2 = P2(3,1:3);

scatter3(pfU(1,:),pfU(2,:),pfU(3,:));
hold on
scatter3(b1(1),b1(2),b1(3))
scatter3(b2(1),b2(2),b2(3))
quiver3(b1(1),b1(2),b1(3),n1(1),n1(2),n1(3),1/norm(n1));
quiver3(b2(1),b2(2),b2(3),n2(1),n2(2),n2(3),1/norm(n2));
hold off 

u1 = pflat(P1*pfU);
u2 = pflat(P2*pfU);
figure
imshow(im1)
hold on
scatter(u1(1,:),u1(2,:))
hold off
figure
imshow(im2)
hold on
scatter(u2(1,:),u2(2,:))
hold off

