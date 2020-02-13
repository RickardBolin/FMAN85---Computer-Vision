load('compEx1data')
load('compEx3data')
Kinv = inv(K);
x1 = Kinv*x{1};
x2 = Kinv*x{2};
