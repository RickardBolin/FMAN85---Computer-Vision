e2 = null(F');
e2x = [0,      -e2(3), e2(2);
       e2(3),    0,   -e2(1);
       -e2(2)    e2(1)   0  ];
e1 = null(e2x*F);
P2 = [e2x*F, e2];