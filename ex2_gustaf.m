close all
clear
load compEx2.mat

church = imread('compEx2.jpg');

l1 = null(p1');
l2 = null(p2');
l3 = null(p3');

imshow(church);
hold on
rital(l1)
rital(l2)
rital(l3)

interline = null([l2'; l3']);
interline = interline/interline(3);
scatter(interline(1),interline(2));
hold off
d = abs(interline'*l1)/sqrt(l1(1)^2 + l1(2)^2);
