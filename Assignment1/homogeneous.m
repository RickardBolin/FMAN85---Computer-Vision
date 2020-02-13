load compEx1.mat

coords2D = pflat(x2D);
coords3D = pflat(x3D);

plot(coords2D(1,:),coords2D(2,:),'.') %Plots a point at (a(1,i),a(2,i)) for  each i.
figure
plot3(coords3D(1,:),coords3D(2,:),coords3D(3,:),'.') %Same as above  but 3D.
axis equal %Makes  sure  that  all  axes  have  the  same  scale.