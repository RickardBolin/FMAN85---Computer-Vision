clear
close all
load compEx3data.mat

cube1 = imread('cube1.JPG');
cube2 = imread('cube2.JPG');

mu = mean(x{1}, 2);
sigma = std(x{1}');

N = [1/sigma(1) 0 -(1/sigma(1))*mu(1);
    0 1/sigma(2) -(1/sigma(2))*mu(2);
    0 0 1];

x1 = N*x{1};


%X = (Xmodel - mean(Xmodel,2))./std(Xmodel')';
X = [Xmodel; ones(1,length(Xmodel))];
M = zeros(111,49);
for i = 1:3:111
    index = floor(i/3) + 1;
    M(i,1:4) = X(:, index)';
    M(i + 1,5:8) = X(:, index)'; 
    M(i + 2,9:12) = X(:, index)'; 
    M(i:i+2,12 + index) = -x1(:, index);
end
[U,S,V] = svd(M);

eig = S(49,49);
v = V(:,end);
mv = norm(M*v);

senior_P = [v(1:4)';v(5:8)';v(9:12)'];

P = N\senior_P;
b1 = null(P);
n1 = P(3,1:3);

scatter3(b1(1),b1(2),b1(3))
hold on
quiver3(b1(1),b1(2),b1(3),n1(1),n1(2),n1(3),1/norm(n1));
scatter3(X(1,:),X(2,:),X(3,:))
