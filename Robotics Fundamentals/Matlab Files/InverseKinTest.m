%Seb Oakes
%Carry out inverse kinematic calculations for 5DOF LynxMotion arm
%requires TransfMat.m (transformation matrix function) to be open alongside this program.


clear all
deg2rad = pi/180;
rad2deg = 180/pi;

%% transformation matrix

%Joint angles  
q1 = 0*deg2rad;
q2 = 30*deg2rad;
q3 = -80*deg2rad;
q4 = 0*deg2rad;
q5 = 0*deg2rad;

%link lengths
L1 = 63;
L2 = 153;
L3 = 153;
L4 = 49;
L5 = 49;

T0e = TransfMat(q1,q2,q3,q4,q5);

T4e = [cos(q5) -sin(q5) 0 0; 0 0 -1 -(L5+L4); sin(q5) cos(q5) 0 0; 0 0 0 1]; %transform necessary for later calcs
T04 = T0e*inv(T4e);



%%

%full transform in algebraic form

%r11 = c1*c234*c5 - s1*s5;
%r12 = -c1*c234*s5 - s1*c5;
%r13 = -c1*s234;
%r21 = s1*c234 + c1*s5;
%r22 = s1*c234 +c1*c5;
%r23 = -s1*s234;
%r31 = c5*s234;
%r32 = -s5*s234;
%r33 = c234;

%px = c1*(c234*c5 + L2*c2 + L3*c23 + (L4+L5)*s234) - s1*s5;
%py = s1*(c234*c5 + L2*c2 + L3*c23 + (L4+L5)*s234) + c1*s5;
%pz = c5*s234 + L1 + L2*s2 + L3*s23 - L4*c234 - L5*c234;


%%
%desired Transformation matrix

Pdes = T0e;  %desired position of wrist
Peff = T0e;

%Pdes = 

T01 = [cos(q1) -sin(q1) 0 0; sin(q1) cos(q1) 0 0; 0 0 1 L1; 0 0 0 1];
T14 = inv(T01)*Pdes*inv(T4e);
T04 = Pdes*inv(T4e);
T1e = T01* Pdes

%variables required for q2,q3 calclation.
x = T1e(1,4);
y = T1e(2,4);
z = T1e(3,4); 

%determine theta1 using x,y position of Eff
Q1a = atan2(T1e(2,4),T1e(1,4)); 
Q1b = Q1a + pi;


% determine q3

rw2 = (x^2 + y^2);
D = -(rw2+ (z-L1)^2 -L2^2 - L3^2)/(2*L2*L3);
Q3a = atan2(sqrt(1-D^2),-D);
Q3b = atan2(-sqrt(1-D^2),-D);


%determine q2

 Q2a = (atan2(z-L1,sqrt(x^2+y^2))) - (atan2(L3*sin(Q3a),L2+L3*cos(Q3a)));
 Q2b = (atan2(z-L1,-sqrt(x^2+y^2))) - (atan2(L3*sin(Q3a),L2+L3*cos(Q3a)));
 Q2c = (atan2(z-L1,sqrt(x^2+y^2))) - (atan2(L3*sin(Q3b),L2+L3*cos(Q3b)));
 Q2d = (atan2(z-L1,-sqrt(x^2+y^2))) - (atan2(L3*sin(Q3b),L2+L3*cos(Q3b)));
        
%theta1 = atan((zwrist - L1)/sqrt(xwrist^2 + ywrist^2));
%theta2 = atan((zwrist - L1)/-sqrt(xwrist^2 + ywrist^2));
%alpha1 = atan((L3*sin(Q3a))/(L2+L3*cos(Q3a)));
%alpha2 = atan((L3*sin(Q3b))/(L2+L3*cos(Q3b)));

%Q2a = (theta1 + alpha1);
%Q2b = (theta1+ alpha2);
%Q2c = (theta2 + alpha1);
%Q2d = (theta2 + alpha2);

%determine q4
beta = (atan2(sqrt(Pdes(3,1)^2+Pdes(3,2)^2),Pdes(3,3)));  %for orientation of effector
BetaDeg = beta*rad2deg % (just to allow me to check the angle)

phi = beta - pi/2;

Q4a = -phi+(pi/2)-Q2a-Q3a;  % four solutions, using all previous Q2,Q3 angles
Q4b =-phi+(pi/2)-Q2b-Q3a;
Q4c = -phi+(pi/2)-Q2c-Q3b;
Q4d = -phi+(pi/2)-Q2d-Q3b;

Q5=0;

%matrix holding solutions
Qsol = [Q1a Q2a Q3a Q4a;
        Q1a Q2c Q3b Q4c; ];
    
      


%Qsol = [Q1a Q2a Q3a Q4a;
        %Q1b Q2b Q3a Q4b; 
       % Q1a Q2c Q3b Q4c; 
       % Q1b Q2d Q3b Q4d];
display '2 solutions:';
    QsolDeg = Qsol*rad2deg
%% Plot arm position


for i=1:2 %loop to step through sets of solutions
  
    
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

%trans45 = [1 0 0 0; 0 1 0 0; 0 0 1 L4; 0 0 0 1];
rot45 = [c5 -s5 0 0; s5 c5 0 0; 0 0 1 0; 0 0 0 1];

trans5e = [1 0 0 0; 0 1 0 0; 0 0 1 L4+L5; 0 0 0 1];

T01 = trans01*rot01;
T12 = x90*rot12;
T23 = trans23*rot23;
T34 = trans34*rot34;
T45 = x90*rot45;
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

plot3(X, Y, Z, '-o');

title('3d representation of Link positions') ; xlabel('x (mm)') ; ylabel('y (mm)'), zlabel ('z (mm)') ;
axis([-450 450 -450 450 -200 450])
%axis equal

text(0,0,0, 'base')

hold on

  
end
