close all
clear
load compEx3.mat
plot ([ startpoints(1 ,:); endpoints(1 ,:)] , ...
[ startpoints(2 ,:); endpoints(2 ,:)] , 'b-');


H1 = [sqrt(3) -1 1; 1 sqrt(3) 1; 0 0 2];
H2 = [1 -1 1; 1 1 0; 0 0 1];
H3 = [1 1 0; 0 2 0; 0 0 1];
H4 = [sqrt(3) -1 1; 1 sqrt(3) 1; 1/4 1/2 2];

sp = [startpoints; ones(1,42)];
ep = [endpoints; ones(1,42)];

s1 = pflat(H1*sp);
e1 = pflat(H1*ep);
plot ([ s1(1 ,:); e1(1 ,:)] , ...
[ s1(2 ,:); e1(2 ,:)] , 'b-');
axis equal
figure
s1 = pflat(H2*sp);
e1 = pflat(H2*ep);
plot ([ s1(1 ,:); e1(1 ,:)] , ...
[ s1(2 ,:); e1(2 ,:)] , 'b-');
axis equal
figure
s1 = pflat(H3*sp);
e1 = pflat(H3*ep);
plot ([ s1(1 ,:); e1(1 ,:)] , ...
[ s1(2 ,:); e1(2 ,:)] , 'b-');
axis equal
figure
s1 = pflat(H4*sp);
e1 = pflat(H4*ep);
plot ([ s1(1 ,:); e1(1 ,:)] , ...
[ s1(2 ,:); e1(2 ,:)] , 'b-');
axis equal
