clear
close all
load compEx1data.mat

mu = mean(x{1}, 2);
sigma = std(x{1}');

N1 = [1/sigma(1) 0 -(1/sigma(1))*mu(1);
    0 1/sigma(2) -(1/sigma(2))*mu(2);
    0 0 1];

mu = mean(x{2}, 2);
sigma = std(x{2}');

N2 = [1/sigma(1) 0 -(1/sigma(1))*mu(1);
    0 1/sigma(2) -(1/sigma(2))*mu(2);
    0 0 1];

M = 