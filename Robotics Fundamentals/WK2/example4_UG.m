%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%           EXAMPLE 4            %
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc
clear all
close all

deg2rad = pi/180;

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Find the transformation matrix of Frame {V} with respect to {U},
% Frame rotates counter-clockwise around z axis

q = 120*deg2rad;
p = [ -3.72 2.10 0 ]';

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Graphical representation of frames
OOx = [ 0 ; p(1,1) ] ;
OOy = [ 0 ; p(2,1) ] ;
plot(OOx,OOy)
axis equal
text(0,0,'O')
ylabel('y'), xlabel('x')
hold on
OOxx = [ p(1,1) ; p(1,1)-2*sin(30*deg2rad) ] ;
OOxy = [ p(2,1) ; p(2,1)+2*cos(30*deg2rad) ] ;
plot(OOxx,OOxy,'k')
text(p(1,1)-2*sin(30*deg2rad),p(2,1)+2*cos(30*deg2rad),'x"')
hold on
OOyx = [ p(1,1) ; p(1,1)-2*sin(60*deg2rad) ] ;
OOyy = [ p(2,1) ; p(2,1)-2*cos(60*deg2rad) ] ;
plot(OOyx,OOyy,'k')
text(p(1,1)-2*sin(60*deg2rad),p(2,1)-2*cos(60*deg2rad),'y"')
text(p(1,1),p(2,1),'O"')

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Abbreviations
cq = cos(q) ;
sq = sin(q) ;

% Rotation Matrix for rotation around z axis
R = [ cq -sq 0 ;
      sq  cq 0 ;
      0   0  1 ] ;

% Transformation Matrix of {V} with respect to {U}
Tuv = [   R   p ;
        0 0 0 1 ] 

