clear
close all
load('sift.mat')

Pa = [10.8623    1.7555   -8.1730  157.2420;
   -2.1797   12.8709   -2.1427  183.2248;
    0.0039    0.0025    0.0025    0.1496];

Pb = [11.7770    2.3359   -6.1660  139.8236;
   -2.3314   13.1369   -2.1903  177.9370;
    0.0031    0.0028    0.0033    0.1505];

X = zeros(4,length(x1));
for i = 1:length(x1)
   M = [Pa, [-x1(:,i); -1], [0; 0; 0] ; Pb, [0; 0; 0], [-x2(:,i); -1]];
   [U,S,V] = svd(M);
   v = V(:,end);
   X(:,i) = v(1:4);
end

X = pflat(X);

xproj1 = pflat( Pa * X );
xproj2 = pflat( Pb * X );

good_points = ( sqrt( sum(( x1 - xproj1(1:2 ,:)).^2)) < 3 & ...
sqrt( sum(( x2 - xproj2(1:2 ,:)).^2)) < 3);

scatter3(X(1,good_points), X(2,good_points), X(3,good_points));


imshow(cube1)
hold on
scatter(x1(1,good_points), x1(2,good_points))
scatter(xproj1(1,good_points),xproj1(2,good_points),'x')


