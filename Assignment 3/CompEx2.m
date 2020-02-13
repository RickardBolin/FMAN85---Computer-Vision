e2 = null(F');
e2x = [0,      -e2(3), e2(2);
       e2(3),    0,   -e2(1);
       -e2(2)    e2(1)   0  ];
e1 = null(e2x*F);
Pb = [e2x*F, e2];
Pa = [eye(3), [0;0;0]];

X = zeros(4,length(x1));
for i = 1:length(senior_x1)
   M = [Pa, [-senior_x1(1:2,i); -1], [0; 0; 0] ; Pb, [0; 0; 0], [-senior_x2(1:2,i); -1]];
   [U,S,V] = svd(M);
   v = V(:,end);
   X(:,i) = v(1:4);
end

X = pflat(X);

xproj1 = pflat( Pa * X );
xproj2 = pflat( Pb * X );
