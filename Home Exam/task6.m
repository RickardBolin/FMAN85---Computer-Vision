clear
close all
restoredefaultpath
addpath('data2020')
load('ex6data.mat')

%%(Lecture 10)

%%  b)
[U, S, V] = svd(A);
% Set all singular values except the first 8 to zero to ensure
% that the rank of the approximation is 8.
newS = S;
newS(9:end,9:end) = 0;
newA = U*newS*V';

% Frobenius norm of the two matrices and the relative error
norm_newA = norm(newA, 'fro');
normA = norm(A, 'fro');
rel_err = norm_newA/normA;

drawface(A(1,:), A(2,:))
hold on
drawface(newA(1,:), newA(2,:), 'r')
hold off

%% c)
% Our basis:
B = U(:,1:8)*newS(1:8,1:8);
% The basis is not uniquely determined, since we could for example
% rotate it by theta degrees and get a new orthogonal basis that still
% fulfill the criteria in (2). More formally (lecture 10):
% B_hat*C_hat^{T} = B*H*H^{?1}*C^{T}=BC^{T}=M, where H is any invertible
% matrix.

