P = [1000 -250 250/sqrt(3) 500;
    0 500*(sqrt(3)-(1/2)) 500*(1+(sqrt(3)/2)) 500;
    0 -1/2 sqrt(3)/2 1];

K = [1000 0 500;
     0 1000 500;
     0   0   1];

Kinv = inv(K);

%Answers for report:
normalizedP = Kinv*P;
p1 = Kinv*[0;0;1];
p2 = Kinv*[0;1000;1];
p3 = Kinv*[1000;0;1];
p4 = Kinv*[1000;1000;1];
