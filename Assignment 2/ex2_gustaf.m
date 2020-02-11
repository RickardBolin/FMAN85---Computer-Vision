clear
close all
load compEx1data.mat

T1 = [1 0 0 0; 0 4 0 0; 0 0 1 0; 0.1 0.1 0 1];
T2 = [1 0 0 0; 0 1 0 0; 0 0 1 0; 0.0625 0.0625 0 1];    


T1P{1} = P{1}*T1;
T2P{1} = P{1}*T2;

[K,R] = rq(P{1}(:,1:3));
K = K./K(3,3);
[T1K,R] = rq(T1P{1}(:,1:3));
T1K = T1K./T1K(3,3);
[T2K,R] = rq(T2P{1}(:,1:3));
T2K = T2K./T2K(3,3);

