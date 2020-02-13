clear
close all
load('sift.mat')

Pa = [10.8623    1.7555   -8.1730  157.2420;
   -2.1797   12.8709   -2.1427  183.2248;
    0.0039    0.0025    0.0025    0.1496];

Pb = [11.7770    2.3359   -6.1660  139.8236;
   -2.3314   13.1369   -2.1903  177.9370;
    0.0031    0.0028    0.0033    0.1505];


<<<<<<< HEAD

PaA = Pa(1:3,1:3);
Pat = Pa(1:3,4);
PbA = Pb(1:3,1:3);
Pbt = Pb(1:3,4);

a_center = -PaA\Pat;
b_center = -PbA\Pbt;

a_dirs = PaA\[x1; ones(1,length(x1))];
b_dirs = PbA\[x2; ones(1,length(x2))];

p1 = zeros(3,length(a_dirs));
p2 = zeros(3,length(b_dirs));
for i = 1:length(a_dirs)
    p1(:,i) = a_center;% + a_dirs(:,i);
    p2(:,i) = b_center;% + b_dirs(:,i);
    v = p2(:,i) - p1(:,i);
    proj_a = ((v'*a_dirs(:,i))./norm(a_dirs(:,i)))*a_dirs(:,i)./norm(a_dirs(:,i));
    proj_b = ((v'*b_dirs(:,i))./norm(b_dirs(:,i)))*b_dirs(:,i)./norm(b_dirs(:,i));
    p1(:,i) = p1(:,i) + proj_a;
    p2(:,i) = p2(:,i) + proj_b;
=======
X = zeros(4,length(x1));
for i = 1:length(x1)
   M = [Pa, [-x1(:,i); -1], [0; 0; 0] ; Pb, [0; 0; 0], [-x2(:,i); -1]];
   [U,S,V] = svd(M);
   v = V(:,end);
   X(:,i) = v(1:4);
   
>>>>>>> a02ca6186e3fefd2804b418966e6fe3ba10e0b6f
end

X = pflat(X);

xproj1 = pflat( Pa * X );
xproj2 = pflat( Pb * X );

good_points = ( sqrt( sum(( x1 - xproj1(1:2 ,:)).^2)) < 3 & ...
sqrt( sum(( x2 - xproj2(1:2 ,:)).^2)) < 3);

scatter3(X(1,good_points), X(2,good_points), X(3,good_points));

<<<<<<< HEAD
scatter3(points(1,:),points(2,:),points(3,:))
scatter3(p1(1,:), p1(2,:), p1(3,:))
hold on
scatter3(p2(1, :), p2(2,:), p2(3,:))
=======
imshow(cube1)
hold on
scatter(x1(1,good_points), x1(2,good_points))
scatter(xproj1(1,good_points),xproj1(2,good_points),'x')
>>>>>>> a02ca6186e3fefd2804b418966e6fe3ba10e0b6f


