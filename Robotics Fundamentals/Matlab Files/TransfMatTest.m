%Seb Oakes
%function to determine homogeneous transformation matrix

function [T0e] = TransfMatTest(q1,q2,q3, q4, q5)


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




baseF = [1 0 0 0;0 1 0 0; 0 0 1 0; 0 0 0 1];

z90 = [0 -1 0 0; 1 0 0 0; 0 0 1 0; 0 0 0 1]; %for +90 degree rotation about z
x90 = [1 0 0 0;0 0 -1 0;0 1 0 0;0 0 0 1];  % ''     ''    ''    about x

trans10 = [1 0 0 0;0 1 0 0; 0 0 1 L1; 0 0 0 1];
rot10 = [c1 -s1 0 0; s1 c1 0 0; 0 0 1 0; 0 0 0 1];

trans21 = x90;
rot21 = [c2 -s2 0 0; s2 c2 0 0; 0 0 1 0; 0 0 0 1];

trans32 = [1 0 0 L2; 0 1 0 0; 0 0 1 0; 0 0 0 1];
rot32 = [c3 -s3 0 0; s3 c3 0 0 ; 0 0 1 0; 0 0 0 1];

trans34 = [1 0 0 L3; 0 1 0 0; 0 0 1 0; 0 0 0 1];
rot34 = [c4 -s4 0 0 ; s4 c4 0 0 ; 0 0 1 0; 0 0 0 1];

%trans45 = [1 0 0 0; 0 1 0 0; 0 0 1 L4; 0 0 0 1];
rot45 = [c5 -s5 0 0; s5 c5 0 0; 0 0 1 0; 0 0 0 1];

transe5 = [1 0 0 0; 0 1 0 0; 0 0 1 L4+L5; 0 0 0 1];

T01 = trans10*rot10;
T12 = x90*rot21;
T23 = trans32*rot32;
T34 = trans34*rot34;
T45 = x90*rot45;
T5e = transe5;

%TeL = [1 0 0 0; 0 1 0 10; 0 0 1 0; 0 0 0 1];
%TeR = [1 0 0 0; 0 1 0 -10; 0 0 1 0; 0 0 0 1];

T0e = T01*T12*T23*T34*T45*T5e;

end
