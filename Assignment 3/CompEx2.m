% clear
% close all
% restoredefaultpath
% addpath('assignment3data')
%load ex1.mat

x1 = x{1};
x2 = x{2};
F = F';

e2 = null(F');
e2x = [0,      -e2(3), e2(2);
       e2(3),    0,   -e2(1);
       -e2(2)    e2(1)   0  ];
e1 = null(e2x*F);
Pb = [e2x*F, e2];
Pa = [eye(3), [0;0;0]];

x1norm = N1*x1;
x2norm = N2*x2;

X = zeros(4,length(x1));
for i = 1:length(x1)
   M = [Pa, [-x1norm(1:2,i); -1], [0; 0; 0] ; Pb, [0; 0; 0], [-x2norm(1:2,i); -1]];
   [U,S,V] = svd(M);
   v = V(:,end);
   X(:,i) = v(1:4);
end

X = pflat(X);

% figure
% axis equal
% scatter3(X(1,:), X(2,:), X(3,:))
% hold off


xproj1 = inv(N1)*pflat( Pa * X );
xproj2 = inv(N2)*pflat( Pb * X );

% figure
% imshow(kron1)
% hold on
% scatter(xproj1(1,:), xproj1(2,:))
% scatter(x1(1,:), x1(2,:), 'rx');
% hold off
% 
figure
imshow(kron2)
hold on
scatter(xproj2(1,:), xproj2(2,:))
%scatter(x2(1,:), x2(2,:), 'rx');
hold off