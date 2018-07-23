%%%%%%%%%%%%% Antonia Tzemanaki %%%%%%%%%%%
%%%%%%%%%%% Robotics Fundamentals %%%%%%%%%
%%%%%%%%%%%%%% October 2017 %%%%%%%%%%%%%
% The following code simulates the forward kinematics of a simple 2DOF
% serial manipulator. Figure 2 shows its movement from start to end
% position, Figure 1 shows the location of its end effector at points of
% its trajectory and Figure 3 shows the maximum potential workspace of the
% arm's end effector.

clear all
close all
clc
disp('The following code simulates the forward kinematics of a simple 2DOF')
disp('serial manipulator. Figure 2 shows its movement from start to end position,')
disp('Figure 1 shows the location of its end effector at points of its trajectory')
disp('and Figure 3 shows the maximum potential workspace of its end effector')

%% A series of joint angles
% The following variables are defined in the form of column-vectors with
% 4 rows each. Each row represents a different position (angle) of the joint.
% e.g. inititally we hae 60 degrees for q1 and -30 for q2.
q1 = [60 70 80 90]'*pi/180 ;
q2 = [-30 -35 -40 -45]'*pi/180 ;
q = [ q1 q2 ] ;


%% Links Lengths
l1 = 0.1 ;
l2 = 0.1 ;

%% Trigonometric abbreviations
c1 = cos(q1);
c2 = cos(q2);
c12 = cos(q1+q2);

s1= sin(q1);
s2 = sin(q2);
s12 = sin(q1+q2);

%% Tip position
% These equations are derived from the Forward Kinematic model of the 2DOF
% robot
xt = l1*c1+l2*c12 ;
yt = l1*s1+l2*s12 ;

pt = [ xt yt ] ;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Plot the trajectory of the end-effector
figure (1)
set(1,'position',[680 558 560 420])

plot3(pt(1,1),pt(1,2),0,'rx')       % plot the first position of the robot's end effector
hold on
plot(pt(2:4,1),pt(2:4,2),'x')       % plot the 3 following positions of the robot's end effector
title('Tip Trajectory') ; xlabel('x (m)') ; ylabel('y (m)') ;


%% Plot the robotic arm, in 4 different positions
figure (2) 
set(2,'position',[116 190 560 420])

x1 = zeros(4,1) ;
y1 = zeros(4,1) ;

x2 = l1*c1 ;
y2 = l1*s1 ;


for i = 1:4
    xx = [ x1(i); x2(i); pt(i,1) ] ;
    yy = [ y1(i); y2(i); pt(i,2) ] ;
    
    plot(xx,yy,'ko-','Linewidth',2)
    axis equal
    hold on
        
    xlabel('x (m)') ; ylabel('y (m)') ;
    text(pt(1,1),pt(1,2),'x') ; text(pt(1,1) + 0.002,pt(1,2) + 0.002,'ptStart') ;
    text(pt(4,1),pt(4,2),'x') ; text(pt(4,1) + 0.002,pt(4,2) + 0.002,'ptEnd') ;
    axis([-0.07 0.15 -0.01 0.18])
    pause(0.05)
    hold off
    pause(0.1)
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Workspace
q1 = 0:pi/180:2*pi-pi/180 ;
q2 = 0:pi/180:2*pi-pi/180 ;

cw1 = cos(q1);
sw1 = sin(q1);
cw12 = zeros(360,360) ;
sw12 = zeros(360,360);

%% Plot the workspace of the robot
figure (3)
set(3,'position',[1243 190 560 420])

xwork = zeros(360,360) ; % reserving space for the variables, because
ywork = zeros(360,360) ; % otherwise they would be created later within a loop.

for i = 1:360	% for q1
    for j = 1:360   % for q2
        cw12(i,j) = cos(q1(1,i)+ q2(1,j));
        sw12(i,j) = sin(q1(1,i)+ q2(1,j));
        xwork(i,j) = l1*cw1(i)+l2*cw12(i,j) ;
        ywork(i,j) = l1*sw1(i)+l2*sw12(i,j) ;
    end
end

plot(xwork,ywork,'.')
axis equal