%%%%%%%%%%%%% Antonia Tzemanaki %%%%%%%%%%
%%%%%%%%%%% Robotic Fundamentals %%%%%%%%%
%%%%%%%%%%%%%% September 2017 %%%%%%%%%%%%

%% This programme shows how to plot vectors
clc
clear
close all

%%
deg2rad = pi/180 ; % multiplying by this will convert degrees to rads

% Plot a new coordinate frame that is rotated counter-clockwise around z axis
% by 120 degrees and translated by p =[-3 2 0]'

p = [ -3 2 0 ]' ; % this is the vector
q = 120*deg2rad ; % this is the rotation angle of the new frame

%%
OOx = [ 0 ; p(1,1)] ;
OOy = [ 0 ; p(2,1)] ;
plot(OOx,OOy) % this plots the p vector
axis equal
text(0.1,-0.05,'O')
ylabel('y'), xlabel('x')
hold on

%%
f = 3 ; % random value which helps plot the axes of the new coordinate frame
OOxx = [ p(1,1) ; p(1,1)-f*sin(30*deg2rad) ] ;
OOxy = [ p(2,1) ; p(2,1)+f*cos(30*deg2rad) ] ;
plot(OOxx,OOxy,'k') % this plots the new x1 axis (with a length of 2)
text(p(1,1)-f*sin(30*deg2rad),p(2,1)+f*cos(30*deg2rad),'x1')
hold on

%%
OOyx = [ p(1,1) ; p(1,1)-f*sin(60*deg2rad) ] ;
OOyy = [ p(2,1) ; p(2,1)-f*cos(60*deg2rad) ] ;
plot(OOyx,OOyy,'k')  % this plots the new y1 axis (with a length of 2)
text(p(1,1)-f*sin(60*deg2rad),p(2,1)-f*cos(60*deg2rad),'y1')
text(p(1,1),p(2,1),'O1')
