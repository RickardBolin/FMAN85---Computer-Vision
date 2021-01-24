clear
close all
restoredefaultpath
addpath('assignment5data')
load data.mat


kron1 = imread('kronan1.JPG');
kron2 = imread('kronan2.JPG');


xproj1 = pflat(K * Pa * X );
xproj2 = pflat(K * Pb * X );

res1before = vecnorm(xproj1 - x{1});
res2before = vecnorm(xproj2 - x{2});

figure
subplot(121)
histogram(res1before)
subplot(122)
histogram(res2before)


x1 = K\x{1};
x2 = K\x{2};


P = {Pa,Pb};
u = {x1,x2};
    
lambda = 1e10;
iterations = 200;

Pnew = P;
Unew = X;

errs = zeros(iterations,1);

for i = 1:iterations
    [err ,res] = ComputeReprojectionError(Pnew,Unew,u);
    errs(i) = err;
    [r,J] = LinearizeReprojErr(Pnew,Unew,u);
    C = J'*J+lambda*speye(size(J,2));
    c = J'*r;
    deltav = -C\c;
    [Pnew ,Unew] = update_solution(deltav ,Pnew ,Unew);
end

figure
plot(errs)

%%

X = Unew;
Pa = Pnew{1};
Pb = Pnew{2};

b1 = pflat(null(Pa));
n1 = Pa(3,1:3)/norm(Pa(3,1:3));
b2 = pflat(null(Pb));
n2 = Pb(3,1:3)/norm(Pb(3,1:3));

xproj1 = pflat(K*Pa * X );
xproj2 = pflat(K*Pb * X );

x1 = pflat(K*x1);
x2 = pflat(K*x2);

res1after = (vecnorm(xproj1 - x{1}));
res2after = (vecnorm(xproj2 - x{2}));

figure
subplot(121)
histogram(res1after)
subplot(122)
histogram(res2after)

good_points = ( sqrt( sum(( x1(1:2 ,:) - xproj1(1:2 ,:)).^2)) < 3 & ...
sqrt( sum(( x2(1:2 ,:) - xproj2(1:2 ,:)).^2)) < 3);

figure
scatter3(Unew(1,good_points),Unew(2,good_points),Unew(3,good_points))
hold on
scatter3(b1(1),b1(2),b1(3))
quiver3(b1(1),b1(2),b1(3),n1(1),n1(2),n1(3),1/norm(n1));
scatter3(b2(1),b2(2),b2(3))
quiver3(b2(1),b2(2),b2(3),n2(1),n2(2),n2(3),1/norm(n2));
hold off

%%
figure
imshow(kron1)
hold on
scatter(x1(1,good_points), x1(2,good_points))
scatter(xproj1(1,good_points),xproj1(2,good_points),'x')
hold off

%%
figure
imshow(kron2)
hold on
scatter(x2(1,good_points), x2(2,good_points))
scatter(xproj2(1,good_points),xproj2(2,good_points),'x')
hold off



