function [bestPlane,mostInliers, bestInlierIdx] = ransac(data,num,iter,threshDist,inlierRatio)
    n_points = size(data,2); mostInliers = 0; bestPlane = [0,0,0,0]; bestInlierIdx = 0;
    for i=1:iter
        idx = randperm(n_points,num); 
        plane = null (data (: , idx )');
        plane = plane ./ norm ( plane (1:3));
        distance = abs (plane' * data);
        inlierIdx = find(abs(distance)<=threshDist);
        inlierNum = length(inlierIdx);   
        if inlierNum>=round(inlierRatio*n_points) && inlierNum>mostInliers
             mostInliers = inlierNum;
             bestInlierIdx = inlierIdx
             bestPlane = plane;
        end
    end
end