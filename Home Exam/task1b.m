% We begin by finding the camera center, which we do by calculating the
% null space of P:

P = [1,0,1,2;
     0,1,3,1;
     0,0,1,0];
 
C = pflat(null(P));
% C = [-2,-1,0,1]

y1 = P*C;
% P*C = [0,0,0]

% As we calculated in 1a, the line between the points is:
% l = = [3+t, 4+t, 1]
% Since we constructed the line using the projections of the provided
% scene points, we know that l'*P*x1, l'*P*x2 and l'*P*x3 will be 0.
% But for the sake of completion, we will do some calculations anyway:

 x1 = [1,1,1,1]';
 x2 = [2,1,2,1]';
 x3 = [-1,0,0,1]';
 
 proj1 = P*x1;
 proj2 = P*x2;
 proj3 = P*x3;
 
 % proj1 = [4,5,1]
 % proj2 = [6,8,2]
 % proj3 = [1,1,0]
 
 % l'*proj1 = [3+t, 4+t, 1]'*[4,5,1] = 21 + 9t -> t = -7/3
 % l'*proj2 = [3+t, 4+t, 1]'*[6,8,2] = 52 + 14t -> t = -26/7
 % l'*proj3 = [3+t, 4+t, 1]'*[1,1,0] = 7 + 2t -> t = -7/2
 
 % The geometric interpretation of l'PX = 0 is that the scene points 
 % that fulfill this equation are all projected onto the line l.