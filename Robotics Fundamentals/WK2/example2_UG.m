%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%           EXAMPLE 2            %
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc
clear
close all

% Find transformation matrix for CLOCKWISE rotation by 40 deg around z axis
% and l=30m.

%%

deg2rad = pi/180

q =  40*deg2rad;          % rotation angle
l =  30;          % link length

% Abbreviations
cq = cos(q) ;
sq = sin(q) ;

% Rotation Matrix for rotation around z axis
Rz = [cq -sq o; sq cq 0; 0 0 1]

%transformation matrix
Tz = [Rz



%%
