clear
close all
load compEx1data.mat
notnan = isfinite(x{1}(1,:));
notnan = isfinite(x{2}(1,:)).*notnan;
x1 = x{1}(:,logical(notnan));
x2 = x{2}(:,logical(notnan));
mu = mean(x1, 2);
sigma = std(x1');
N1 = [1/sigma(1) 0 -(1/sigma(1))*mu(1);
    0 1/sigma(2) -(1/sigma(2))*mu(2);
    0 0 1];
senior_x1 = N1*x1;
mu = mean(x2, 2);
sigma = std(x2');
N2 = [1/sigma(1) 0 -(1/sigma(1))*mu(1);
    0 1/sigma(2) -(1/sigma(2))*mu(2);
    0 0 1];
senior_x2 = N2*x2;

M = zeros(length(x1), 9);
for i = 1:length(x1)
    M(i,1:3) = senior_x1(1,i)*[1 1 1].*senior_x2(:,i)';
    M(i,4:6) = senior_x1(2,i)*[1 1 1].*senior_x2(:,i)';
    M(i,7:9) = senior_x1(3,i)*[1 1 1].*senior_x2(:,i)';
end
[U,S,V] = svd(M);

lambda = S(9,9);
v = V(:,9);
senior_F = reshape(v,[3,3])';

[U,S,V] = svd(senior_F);
S(3,3) = 0;
senior_F = U*S*V';
F = N2'*senior_F*N1;

plot(diag(senior_x2'*senior_F*senior_x1));

l = F*x{1};
l = l ./ sqrt ( repmat ( l (1 ,:).^2 + l (2 ,:).^2 ,[3 1]));
rital(l(:,1))

