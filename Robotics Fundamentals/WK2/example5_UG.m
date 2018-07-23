%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%           EXAMPLE 5            %
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc
clear all
close all

%% Rotation
deg2rad = pi/180 ;
rad2deg = 180/pi ;
qx = -60*deg2rad ;
qy = 45*deg2rad ;
qz = 90*deg2rad ;
Rx = [ 1   0       0    ;
       0 cos(qx) -sin(qx) ;
       0 sin(qx)  cos(qx) ] ; % rotation around x
 
Ry = [ cos(qy) 0 sin(qy) ;
         0    1   0    ;
      -sin(qy) 0 cos(qy) ] ; % rotation around y

Rz = [ cos(qz) -sin(qz) 0 ;
       sin(qz)  cos(qz) 0 ;
         0       0    1 ] ; % rotation around z
   
Rzyx = Rz*Ry*Rx; % roll, pitch, yaw
Rzyx % this matrix describes the rotation of {1} with respect to the world frame {O}

%% Find the ZYZ Euler angles
% in rad:
b = atan2(sqrt(Rzyx(3,1)^2+Rzyx(3,2)^2),Rzyx(3,3)) ;
if sin(b)~=0
    a = atan2(Rzyx(2,3)/sin(b),Rzyx(1,3)/sin(b)) ;
    c = atan2(Rzyx(3,2)/sin(b),-Rzyx(3,1)/sin(b)) ;
else
    error('sin(b)=0')
end

Ra = [ cos(a) -sin(a) 0 ;
       sin(a)  cos(a) 0 ;
         0       0    1 ] ;
     
Rb = [ cos(b) 0 sin(b) ;
          0    1   0     ;
      -sin(b) 0 cos(b) ] ;     
     
Rc = [ cos(c) -sin(c) 0 ;
       sin(c)  cos(c) 0 ;
         0       0    1 ] ;
Rzyz = Ra*Rb*Rc ;
Rzyz
% Compare Ryz and Rzyx. You can easily convert from different Euler angles!

%% Translation
p = [4 -3 7] ; % position of frame {1} with respect to [1 0 0;
                                                      % 0 1 0;
                                                      % 0 0 1]
 
%% Homogenous Matrix
T = [ Rzyx  p' ;
      0 0 0  1 ]


%% transform point P1=[1 1 1] referenced in {1}, to the world frame {O}
p1 = [1 1 1] ; % position vector p1 going from origin of {R_all}/{1} to P1
Po = Rzyx*p1'+p'

%%%%%%%%%%%%%%%%%%%%%%%%%%%
%or:
Po2 = T*[p1 1]'

%%%%%%%%%%%%%%
