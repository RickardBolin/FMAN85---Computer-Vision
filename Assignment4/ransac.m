function [bestPlane] = ransac(data,num,iter,threshDist,inlierRatio)
 % data: a 2xn dataset with #n data points
 % num: the minimum number of points. For line fitting problem, num=2
 % iter: the number of iterations
 % threshDist: the threshold of the distances between points and the fitting line
 % inlierRatio: the threshold of the number of inliers 
 
 % Plot the data points
 figure; scatter3(data(1,:),data(2,:),data(3,:));hold on;
 n_points = size(data,2); % Total number of points
 bestInNum = 0; % Best fitting line with largest number of inliers
 bestPlane = [0,0,0,0];% parameters for best fitting line
 for i=1:iter
 % Randomly select 3 points
     idx = randperm(n_points,num); 
 % Compute the distances between all points with the fitting line
     plane = null (data (: , idx )');
     plane = plane ./ norm ( plane (1:3));
     distance = abs (plane' * data);
     sum(distance)
 % Compute the inliers with distances smaller than the threshold
     inlierIdx = find(abs(distance)<=threshDist);
     inlierNum = length(inlierIdx);
 % Update the number of inliers and fitting model if better model is found     
     if inlierNum>=round(inlierRatio*n_points) && inlierNum>bestInNum
         bestInNum = inlierNum;         
         bestPlane = plane;
     end
 end
 
 % Plot the best fitting plane
 syms x y
 z = -(bestPlane(1)*x+bestPlane(2)*y+bestPlane(4))/bestPlane(3);
 fmesh(z)
 
end