A2 = [-700/sqrt(2),1400,700/sqrt(2)]';
R3 = [-1/sqrt(2),0,1/sqrt(2)]';
e = A2'*R3;

A2 - e*R3

R2 = [0,1,0]';

cross(R2,R3)