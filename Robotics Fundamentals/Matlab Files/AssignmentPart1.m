

clc
clear
close all

%deg top rad conversion

deg2rad = pi/180;




%Joint angles
q1 = 0*deg2rad;
q2 = 0*deg2rad;
q3 = 0*deg2rad;
q4 = 0*deg2rad;
q5 = 0*deg2rad;

%link lengths

L1 = 63;
L2 = 153;
L3 = 153;
L4 = 49;
L5 = 49;


%trig abbrev.
c1 = cos(q1);
c2 = cos(q2);
c3 = cos(q3);
c4 = cos(q4);
c5 = cos(q5);
s1 = sin(q1);
s2 = sin(q2);
s3 = sin(q3);
s4 = sin(q4);
s5 = sin(q5);
%s23 = sin(q2+q3);
%s234 = sin(q2+q3+q4);
%c23 = cos(q2+q3);
%c234 = cos(q2+q3+q4);

%end effector position
%xe = ((L2*s2) + (L3*s23) + (L4*s234))*c1;
%ye = ((L2*s2) + (L3*s23) + (L4*s234))*s1;
%ze = L1 + (L2*c2) + (L3*c23) + (L4*c234);

base = [1 0 0 0;0 1 0 0; 0 0 1 0; 0 0 0 1];

%%
%Transformation Matrices

z90 = [0 -1 0 0; 1 0 0 0; 0 0 1 0; 0 0 0 1]; %for +90 degree rotation about z
x90 = [1 0 0 0;0 0 -1 0;0 1 0 0;0 0 0 1];  % ''     ''    ''    about x

trans10 = [1 0 0 0;0 1 0 0; 0 0 1 L1; 0 0 0 1];
rot10 = [c1 -s1 0 0; s1 c1 0 0; 0 0 1 0; 0 0 0 1];

trans21 = x90;
rot21 = [c2 -s2 0 0; s2 c2 0 0; 0 0 1 0; 0 0 0 1];

trans32 = [1 0 0 L2; 0 1 0 0; 0 0 1 0; 0 0 0 1];
rot32 = [c3 -s3 0 0; s3 c3 0 0 ; 0 0 1 0; 0 0 0 1];

trans43 = [1 0 0 L3; 0 1 0 0; 0 0 1 0; 0 0 0 1];
rot43 = [c4 -s4 0 0 ; s4 c4 0 0 ; 0 0 1 0; 0 0 0 1];

trans54 = [1 0 0 0; 0 1 0 0; 0 0 1 L4; 0 0 0 1];
rot54 = [c5 -s5 0 0; s5 c5 0 0; 0 0 1 0; 0 0 0 1];

transe5 = [1 0 0 0; 0 1 0 0; 0 0 1 L5; 0 0 0 1];

T10 = trans10*rot10;
T21 = x90*rot21;
T32 = trans32*rot32;
T43 = trans43*z90*rot43;
T54 = x90*trans54*rot54;
Te5 = transe5;

% full homogeneous transform

Te0 = base*T10*T21*T32*T43*T54*Te5;

%% Joint positions

base = [1 0 0 0;0 1 0 0; 0 0 1 0; 0 0 0 1];
% joint 4x4 matrices after hom. transform
Jmat1 = T10*base;
Jmat2 = Jmat1*T21;
Jmat3 = Jmat2*T32;
Jmat4 = Jmat3*T43;
Jmat5 = Jmat4*T54;
effmat = Jmat5*Te5;

% joint position vectors

baseV = [0 0 0]';
JV1 = [Jmat1(1,4), Jmat1(2,4), Jmat1(3,4)]';
JV2 = [Jmat2(1,4), Jmat2(2,4), Jmat2(3,4)]';
JV3 = [Jmat3(1,4), Jmat3(2,4), Jmat3(3,4)]';
JV4 = [Jmat4(1,4), Jmat4(2,4), Jmat4(3,4)]';
JV5 = [Jmat5(1,4), Jmat5(2,4), Jmat5(3,4)]';
JVe = [effmat(1,4), effmat(2,4), effmat(3,4)]';

% create seperate x,y,z arrays for line plot
X = [base(1,4) Jmat1(1,4) Jmat2(1,4) Jmat3(1,4) Jmat4(1,4) Jmat5(1,4) effmat(1,4)]; 
Y = [base(2,4) Jmat1(2,4) Jmat2(2,4) Jmat3(2,4) Jmat4(2,4) Jmat5(2,4) effmat(2,4)];
Z = [base(3,4) Jmat1(3,4) Jmat2(3,4) Jmat3(3,4) Jmat4(3,4) Jmat5(3,4) effmat(3,4)];


%extracting frame orientation from effector homegeneous matrix
%eff.frameX = [effmat(1,1) effmat(2,1) effmat(3,1)];
%eff.frameZ = [effmat(1,3) effmat(2,3) effmat(3,3)];






%% Plot lines connecting frames


figure (1)
set(1,'position',[200 300 400 400]) %Set figure position

plot3(X, Y, Z,'-o');



%text(Jmat1(1,4), Jmat1(2,4), Jmat1(3,4), 'J1')
%text(Jmat2(1,4), Jmat2(2,4), Jmat2(3,4), 'J2')
%text(Jmat3(1,4), Jmat3(2,4), Jmat3(3,4), 'J3')
%text(Jmat4(1,4), Jmat4(2,4), Jmat4(3,4), 'J4')
%text(Jmat5(1,4), Jmat5(2,4), Jmat5(3,4), 'J5')


title('3d representation of Link positions') ; xlabel('x (mm)') ; ylabel('y (mm)'), zlabel ('z (mm)') ;
axis([-400 400 -400 400 0 400])
text(0,0,0, 'base')
text(effmat(1,4), effmat(2,4), effmat(3,4), 'Eff')





hold on

%% Workspace


varq1 = (0:10:180)*deg2rad; %180deg range  - info found on technical sheet for arm
varq2 = (0:10:180)*deg2rad; %180deg range
varq3 = (-10:10:170)*deg2rad; %180deg range
varq4 = (-90:10:90)*deg2rad; %180 deg range

xwork = zeros(15000,1) ; % reserving space for the variables, because
ywork = zeros(15000,1) ; % otherwise they would be created later within a loop.
zwork = zeros(15000,1) ;

figure (2)
set(2,'position',[1243 190 560 420])

i=1; %set initial integer values for loops (to fill work arrays)



for q1 = varq1

    for q2 = varq2
       

        for q3 = varq3
            
            for q4 = varq4
                
c1 = cos(q1);
c2 = cos(q2);
c3 = cos(q3);
c4 = cos(q4);
c5 = cos(q5);
s1 = sin(q1);
s2 = sin(q2);
s3 = sin(q3);
s4 = sin(q4);
s5 = sin(q5);

z90 = [0 -1 0 0; 1 0 0 0; 0 0 1 0; 0 0 0 1]; %for +90 degree rotation about z
x90 = [1 0 0 0;0 0 -1 0;0 1 0 0;0 0 0 1];  % ''     ''    ''    about x

trans10 = [1 0 0 0;0 1 0 0; 0 0 1 L1; 0 0 0 1];
rot10 = [c1 -s1 0 0; s1 c1 0 0; 0 0 1 0; 0 0 0 1];

trans21 = x90;
rot21 = [c2 -s2 0 0; s2 c2 0 0; 0 0 1 0; 0 0 0 1];

trans32 = [1 0 0 L2; 0 1 0 0; 0 0 1 0; 0 0 0 1];
rot32 = [c3 -s3 0 0; s3 c3 0 0 ; 0 0 1 0; 0 0 0 1];

trans43 = [1 0 0 L3; 0 1 0 0; 0 0 1 0; 0 0 0 1];
rot43 = [c4 -s4 0 0 ; s4 c4 0 0 ; 0 0 1 0; 0 0 0 1];

trans54 = [1 0 0 0; 0 1 0 0; 0 0 1 L4; 0 0 0 1];
rot54 = [c5 -s5 0 0; s5 c5 0 0; 0 0 1 0; 0 0 0 1];



T10 = trans10*rot10;
T21 = x90*rot21;
T32 = trans32*rot32;
T43 = trans43*z90*rot43;
T54 = x90*trans54*rot54;


HomMat = base*T10*T21*T32*T43*T54; % hom. transf. matrix for 5th joint.

xwork(i,1) = HomMat(1,4);
ywork(i,1) = HomMat(2,4);
zwork(i,1) = HomMat(3,4);        
i=i+1; % add one to integer value

            end
           
        end
       
    end
    
end    
plot3(xwork,ywork,zwork, '.');
axis equal
hold on;
text(0,0,0, 'base');
scatter3(base(1,4),base(2,4),base(3,4), 'dr','MarkerFaceColor', 'b');

