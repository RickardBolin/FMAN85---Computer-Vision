clear
close all
restoredefaultpath
addpath('assignment3data')
load compEx1data.mat
load compEx3data.mat
kron1 = imread('kronan1.JPG');
kron2 = imread('kronan2.JPG');
x1 = x{1};
x2 = x{2};

y1 = K\x1;
y2 = K\x2;

M = zeros(length(y1), 9);
for i = 1:length(y1)
    M(i,1:3) = y1(1,i)*[1 1 1].*y2(:,i)';
    M(i,4:6) = y1(2,i)*[1 1 1].*y2(:,i)';
    M(i,7:9) = y1(3,i)*[1 1 1].*y2(:,i)';
end
[U,S,V] = svd(M);
E = reshape(V(:,9), [3 3]);

%correct
plot(diag(y2'*E*y1));

[U,S,V] = svd(E);

if det (U*V') >0
    E = U* diag ([1 1 0])* V';
else
    V = -V;
    E = U* diag ([1 1 0])* V';
end

figure
perm = randperm( size ( x{1} ,2));

l = K'\E/K*x1;
l = l ./ sqrt ( repmat ( l(1 ,:).^2 + l(2 ,:).^2 ,[3 1]));
figure
imshow(kron1)
hold on
scatter(x1(1,perm(1:10)), x1(2,perm(1:10)),'ro')
figure
imshow(kron2)
hold on
rital(l(:,perm(1:10)))
scatter(x2(1,perm(1:10)), x2(2,perm(1:10)),'ro')
hold off
figure
hist ( abs ( sum ( l.*x2)) ,100);

save('ex3.mat', 'E');

%E./E(3,3)


