clear
close all
restoredefaultpath
addpath('assignment4data')
addpath('../vlfeat-0.9.21/toolbox')
vl_setup

a = imread('a.jpg');
b = imread('b.jpg');


[ fA, dA ] = vl_sift ( single ( rgb2gray (a )) );
[ fB, dB ] = vl_sift ( single ( rgb2gray (b )) );
matches = vl_ubcmatch (dA , dB );
xA = fA (1:2 , matches (1 ,:));
xB = fB (1:2 , matches (2 ,:));
<<<<<<< HEAD

=======
    
xA = [xA; ones(1,length(xA))];
xB = [xB; ones(1,length(xB))];

outliers = zeros(100,1);

for iter = 1:10000
    
    perm = randperm(length(xA));
    
    bois = perm(1:8);
    
    M = zeros(2*length(bois),9);
    for i = 1:length(bois)
        idx = (i-1)*2;
        M(idx + 1, 1:3) = xA(:,bois(i))';
        M(idx + 2, 4:6) = xA(:,bois(i))';
        M(idx + 1, 7:9) = -xB(1,bois(i)).*xA(:,bois(i))';
        M(idx + 2, 7:9) = -xB(2,bois(i)).*xA(:,bois(i))';
    end

    [U,S,V] = svd(M);
    H = reshape(V(:,end), [3 3]);
    xBt = pflat(H'*xA);
    outliers(iter) = sum(vecnorm(xBt - xB) > 5);
    if(outliers(iter) < 55)
        disp("outliers < 55")
        break
    end
end

goodbois = vecnorm(xBt - xB) <= 5;

figure
imagesc([a b]);
hold on
plot ([ xA(1 , goodbois); xB(1 , goodbois)+ size( a ,2)] , ...
[ xA(2 , goodbois); xB(2 , goodbois)] , '-' );
hold off

%%
bestH = double(H);
tform = maketform('projective', bestH);
transfbounds = findbounds( tform ,[1 1; size(a ,2) size(a ,1)]);
% Finds the bounds of the transformed image
xdata = [ min([ transfbounds(: ,1); 1]) max([ transfbounds(: ,1); size(b ,2)])];
ydata = [ min([ transfbounds(: ,2); 1]) max([ transfbounds(: ,2); size(b ,1)])];
% Computes bounds of a new image such that both the old ones will fit .
[ newA ] = imtransform(a , tform , 'xdata' , xdata , 'ydata', ydata );
% Transform the image using bestH
tform2 = maketform( 'projective', eye (3));
[ newB ] = imtransform(b , tform2 , 'xdata', xdata , 'ydata' , ydata , 'size', size ( newA ));
% Creates a larger version of B
newAB = newB ;
newAB( newB < newA ) = newA( newB < newA );
>>>>>>> e44478cf22b76f04afa8451788a210afaf505935
