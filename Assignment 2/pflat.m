function [coords] = pflat(x)
lastRow = x(end, :); %Extracts  the  last  row of x
coords = x./lastRow; %Elementwise  division.%Divides  the  elements  of a by the  corresponding  element  of b.