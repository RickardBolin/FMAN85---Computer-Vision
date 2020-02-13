P1 = [eye(3,3),zeros(3,1)];
P2 = [1,1,1,2;
      0,2,0,2;
      0,0,1,0];

e1 = P1*([P2(:,4);1]);
e2 = P2*([P1(:,4);1]);

F = [0,0,2;0,0,-2;-2,2,0]*[1,1,1;0,2,0;0,0,1];

det(F)% = 0
e2'*F% = 0
F*e1% = 0

