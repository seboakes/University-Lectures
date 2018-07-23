%Sebastian Oakes
%Program simulating the picking up and placing down of an object at another location, while
%keeping end effector level. Arm starts at, and returns to default position, coordinates (100,100,100) 

clc
clear
close all

deg2rad = pi/180;
rad2deg = 180/pi;


%Define Link lengths

L1 = 63;
L2 = 153;
L3 = 153;
L4 = 49;
L5 = 49;
stepNum = 30; %steps between nodes


 
 %list of x,y,z node coordinates for path planning
 
PNX = [100 100 200 200  0  0 0 100]';  
PNY = [100 0 0 0 200   200 100 100]';
PNZ = [100 0 0 200 200  0 0 100]';
   
orient1 = [0 0 1; 0 -1 0; 1 0 0]; %orientation of end effector

%orient2 = [];


for k = 1:7 %loop for moving between nodes
 
%Line vectors to supply x,y,z positions for inverse Kin. PPx = pathpoint x


%plot3(PPx, PPy, PPz, 'o-');
%title('Visualisation of path nodes');

for j  = 1:stepNum   %loop to add points on path between nodes 
    
   for i = 2  % NOTE - i can be set as 1 or 2 to choose between solutions
       
PPx = linspace(PNX(k), PNX(k+1), stepNum);
PPy = linspace(PNY(k), PNY(k+1), stepNum);
PPz = linspace(PNZ(k), PNZ(k+1), stepNum);

%determine Q1    
Q1a = atan2(PPy(j),PPx(j)); 
Q1b = Q1a + pi;

%determine Q3

x = PPx(j);
y = PPy(j);
z = PPz(j);
rw2 = (x^2 + y^2);
D = -(rw2+ (z-L1)^2 -L2^2 - L3^2)/(2*L2*L3);
Q3a = atan2(sqrt(1-D^2),-D);
Q3b = atan2(-sqrt(1-D^2),-D);

%determine Q2

Q2a = (atan2(z-L1,sqrt(x^2+y^2))) - (atan2(L3*sin(Q3a),L2+L3*cos(Q3a)));
 Q2b = (atan2(z-L1,-sqrt(x^2+y^2))) - (atan2(L3*sin(Q3a),L2+L3*cos(Q3a)));
 Q2c = (atan2(z-L1,sqrt(x^2+y^2))) - (atan2(L3*sin(Q3b),L2+L3*cos(Q3b)));
 Q2d = (atan2(z-L1,-sqrt(x^2+y^2))) - (atan2(L3*sin(Q3b),L2+L3*cos(Q3b)));

%determine Q4

beta = pi/2; %(atan2(sqrt(orient1(3,1)^2+ orient1(3,2)^2),orient1(3,3)));  %for orientation of effector
BetaDeg = beta*rad2deg; % (just to allow me to check the angle)

phi = beta - (pi/2);  %ie angle w.r.t horizontal

Q4a = -phi+(pi/2)-Q2a-Q3a;  % four solutions, using all previous Q2,Q3 angles
Q4b =-phi+(3*pi/2)-Q2b-Q3a;
Q4c =-phi+(pi/2)-Q2c-Q3b;
Q4d =-phi+(3*pi/2)-Q2d-Q3b;

Q5=0;


%Qsol = [Q1a Q2a Q3a Q4a;
      %  Q1a Q2c Q3b Q4c];
%matrix holding solutions    
Qsol = [Q1a Q2a Q3a Q4a;
        Q1b Q2b Q3a Q4b; 
        Q1a Q2c Q3b Q4c; 
        Q1b Q2d Q3b Q4d];
 
Q1 = Qsol(i,1);
Q2 = Qsol(i,2);
Q3 = Qsol(i,3);
Q4 = Qsol(i,4);
Q1deg = Q1*rad2deg; %angles in deg for reference
Q2deg = Q2*rad2deg;
Q3deg = Q3*rad2deg;


 
c1 = cos(Q1);
c2 = cos(Q2);
c3 = cos(Q3);
c4 = cos(Q4);
c5 = cos(Q5);
s1 = sin(Q1);
s2 = sin(Q2);
s3 = sin(Q3);
s4 = sin(Q4);
s5 = sin(Q5);

c23 = cos(Q2+Q3);
s23 = sin(Q2+Q3);

baseF = [1 0 0 0;0 1 0 0; 0 0 1 0; 0 0 0 1];

%%
%Transformation Matrices

z90 = [0 -1 0 0; 1 0 0 0; 0 0 1 0; 0 0 0 1]; %for +90 degree rotation about z
x90 = [1 0 0 0;0 0 -1 0;0 1 0 0;0 0 0 1];  % ''     ''    ''    about x

trans01 = [1 0 0 0;0 1 0 0; 0 0 1 L1; 0 0 0 1];
rot01 = [c1 -s1 0 0; s1 c1 0 0; 0 0 1 0; 0 0 0 1];

trans12 = x90;
rot12 = [c2 -s2 0 0; s2 c2 0 0; 0 0 1 0; 0 0 0 1];

trans23 = [1 0 0 L2; 0 1 0 0; 0 0 1 0; 0 0 0 1];
rot23 = [c3 -s3 0 0; s3 c3 0 0 ; 0 0 1 0; 0 0 0 1];

trans34 = [1 0 0 L3; 0 1 0 0; 0 0 1 0; 0 0 0 1];
rot34 = [c4 -s4 0 0 ; s4 c4 0 0 ; 0 0 1 0; 0 0 0 1];

trans45 = [1 0 0 0; 0 1 0 0; 0 0 1 L4; 0 0 0 1];
rot45 = [c5 -s5 0 0; s5 c5 0 0; 0 0 1 0; 0 0 0 1];

trans5e = [1 0 0 0; 0 1 0 0; 0 0 1 L5; 0 0 0 1];

T01 = trans01*rot01;
T12 = x90*rot12;
T23 = trans23*rot23;
T34 = trans34*rot34;
T45 = x90*trans45*rot45;
T5e = trans5e;

TeL = [1 0 0 0; 0 1 0 10; 0 0 1 0; 0 0 0 1];
TeR = [1 0 0 0; 0 1 0 -10; 0 0 1 0; 0 0 0 1]; %added translations to allow better orientationalrepresentation of end effector

% full homogeneous transform

T0e = T01*T12*T23*T34*T45*T5e;

%% Joint positions

base = [1 0 0 0;0 1 0 0; 0 0 1 0; 0 0 0 1];
% joint 4x4 matrices after hom. transform
J1pos = T01*base;
J2pos = T01*T12*base;
J3pos = T01*T12*T23*base;
J4pos = T01*T12*T23*T34*base;
J5pos = T01*T12*T23*T34*T45*base;
effpos = T01*T12*T23*T34*T45*T5e*base;
effL = T01*T12*T23*T34*T45*T5e*TeL*base;
effR = T01*T12*T23*T34*T45*T5e*TeR*base;
% joint position vectors



% create seperate x,y,z arrays for line plot
X = [base(1,4) J1pos(1,4) J2pos(1,4) J3pos(1,4) J4pos(1,4) J5pos(1,4) effpos(1,4) effL(1,4) effR(1,4)]; 
Y = [base(2,4) J1pos(2,4) J2pos(2,4) J3pos(2,4) J4pos(2,4) J5pos(2,4) effpos(2,4) effL(2,4) effR(2,4)];
Z = [base(3,4) J1pos(3,4) J2pos(3,4) J3pos(3,4) J4pos(3,4) J5pos(3,4) effpos(3,4) effL(3,4) effR(3,4)];

x5pos = L4*(c4*s1*c23 - s4*c1*(c2*c3 - s2*c3)) + L3*c1*c23 + L2*c1*c2;
y5pos = L4*(c4*s1*c23 - s4*s1*(c2*s3 - s2*c3)) + L3*s1*c23 - L2*s1*c2;
z5pos = L4*(c4*s23 - s4*c23) + L3*s23 + L2*s2 +L1;








%% Plot lines connecting frames


figure (1)
set(1,'position',[200 300 400 400]) %Set figure position


plot3(PNX, PNY, PNZ, 'x-.');
hold on
plot3(X, Y, Z, '-o');


title('3d representation of Link positions') ; xlabel('x (mm)') ; ylabel('y (mm)'), zlabel ('z (mm)') ;
axis([-100 450 -100 450 -200 450])
%axis equal

text(0,0,0, 'base')
grid on;

pause(0.01);
hold off;

    end
end

end

