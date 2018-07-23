%%%%%%%%%%%%% Antonia Tzemanaki %%%%%%%%%%
%%%%%%%%%%% Robotic Fundamentals %%%%%%%%%
%%%%%%%%%%%%%% September 2017 %%%%%%%%%%%%

function C = my_mult(A,B)

% this is a function for multiplication of 2x2 matrices

C = zeros(2,2) ;
C(1,1) = A(1,1)*B(1,1)+A(1,2)*B(2,1) ;
C(1,2) = A(1,1)*B(1,2)+A(1,2)*B(2,2) ;
C(2,1) = A(2,1)*B(1,1)+A(2,2)*B(2,1) ;
C(2,2) = A(2,1)*B(1,2)+A(2,2)*B(2,2) ;