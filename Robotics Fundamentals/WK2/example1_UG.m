%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%           EXAMPLE 1            %
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc
clear
close all

%%
deg2rad = pi/180;

% Find rotation matrix for counter-clockwise rotation by 45 deg around y axis
q = 45*deg2rad;  % rotation angle
l = 50;          % link length

% Abbreviations
cq = cos(q) ;
sq = sin(q) ;

% Rotation Matrix for rotation around y axis
Ry = [ cq 0 sq ;
       0  1  0 ;
      -sq 0 cq ] ;

% Translational coordinates
x = cq*l ;
z = sq*l ;

%% Transformation matrix
Ty = [ Ry   [x 0 z]' ;
      0 0 0    1   ] 
 
%% Ploting...

% Initial position
q0 = 0 ;
x0 = cos(q0)*l ;
z0 = sin(q0)*l ;
xx0 = [ 0 ; x0 ] ;
zz0 = [ 0 ; z0 ] ;

plot(xx0, zz0, 'k')
hold on

% Desired position
xxd = [ 0 ; x] ;
zzd = [ 0 ; z] ;

plot(xxd, zzd, 'r')
axis equal
