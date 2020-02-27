clear
close all
restoredefaultpath
addpath('assignment4data')

a = imread('a.jpg');
b = imread('b.jpg');

figure
imshow(a)
figure
imshow(b)

[ fA, dA ] = vl_sift ( single ( rgb2gray (a )) );
[ fB, dB ] = vl_sift ( single ( rgb2gray (b )) );
matches = vl_ubcmatch (dA , dB );
xA = fA (1:2 , matches (1 ,:));
xB = fB (1:2 , matches (2 ,:));