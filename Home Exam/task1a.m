clear
clc

P = [1,0,1,2;
     0,1,3,1;
     0,0,1,0];
 
 x1 = [1,1,1,1]';
 x2 = [2,1,2,1]';
 x3 = [-1,0,0,1]';
 
 proj1 = P*x1;
 proj2 = P*x2;
 proj3 = P*x3;
 
 proj1flat = pflat(proj1);
 proj2flat = pflat(proj2);
 %pflat(proj3) % Point at infinity, pflat doesn't work
 
 % Check if determinant of the following matrix 
 % is zero to determine if they are on the same line:
 area = det([proj1flat,proj2flat,proj3]');
 % The area is equal to zero. Therefore, if the points were vertices 
 % in a triangle, the area of that triangle would be zero -> They are on a line
 

