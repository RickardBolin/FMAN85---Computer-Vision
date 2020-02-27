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

xA = [xA; ones(1,length(xA))];
xB = [xB; ones(1,length(xB))];

M = zeros(2*length(xA),9);

for i = 1:length(xA)
    idx = (i-1)*3;
    M(idx + 1, 1:3) = xA';
    M(idx + 2, 4:6) = xA';
    M(idx + 1, 7:9) = -xB(1,:).*xA';
    M(idx + 2, 7:9) = -xB(2,:).*xA';
end

[U,S,V] = svd(M);

H = reshape(V(9,:), [3 3]);




