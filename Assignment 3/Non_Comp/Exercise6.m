clear
close all
restoredefaultpath
addpath('assignment3data')

U = [1/sqrt(2),-1/sqrt(2),0;1/sqrt(2),1/sqrt(2),0;0,0,1];
V = [1,0,0;0,0,-1;0,1,0];
det(U*V'); % = 1
E = U*diag([1,1,0])*V';

x1 = [0;0;1];
x2 = [1;1;1];
x2'*E*x1; % = 0

W = [0,-1,0;1,0,0;0,0,1];
P2_1 = [U*W*V', U(:,3)];
P2_2 = [U*W*V', -U(:,3)];
P2_3 = [U*W'*V', U(:,3)];
P2_4 = [U*W'*V', -U(:,3)];

pflat(P2_1*X(-1/sqrt(2)))
pflat(P2_2*X(1/sqrt(2)))
pflat(P2_3*X(1/sqrt(2)))
pflat(P2_4*X(-1/sqrt(2)))

function a = X(s)
    a = [0;0;1;s];
end


