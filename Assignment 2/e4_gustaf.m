clear 
close all

cube1 = imread('cube1.JPG');
cube2 = imread('cube2.JPG');
[f1 d1] = vl_sift(single(rgb2gray(cube1)), 'PeakThresh', 1);
[f2 d2] = vl_sift(single(rgb2gray(cube2)), 'PeakThresh', 1);
figure
imshow(cube1)
hold on
vl_plotframe(f1)
hold off
figure
imshow(cube2)
hold on
vl_plotframe(f2)
hold off

[matches,scores] = vl_ubcmatch(d1,d2);
x1 = [ f1(1 , matches (1 ,:)); f1(2 , matches (1 ,:))];
x2 = [ f2(1 , matches (2 ,:)); f2(2 , matches (2 ,:))];

perm = randperm( size ( matches ,2));
figure
imagesc([cube1 cube2]);
hold on
plot ([ x1(1 , perm (1:10)); x2(1 , perm (1:10))+ size( cube1 ,2)] , ...
[ x1(2 , perm (1:10)); x2(2 , perm (1:10))] , '-' );
