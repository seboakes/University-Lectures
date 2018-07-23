%%%%%%%%%%%%% Antonia Tzemanaki %%%%%%%%%%
%%%%%%%%%%%%% Robotic Systems %%%%%%%%%$
%%%%%%%%%%%%%% September 2017 %%%%%%%%%%%%

%% This programme shows how to use a function that you have already created
% (see my_mult.m).  
% simpleExample.m is the main program

clear
close all
clc

%% Define the matrices:
L= [ 4 5 ;
     7 9 ] ;
 
K = [ 6 2;
      2 0 ] ;
 
%% Multiply 2x2 matrices without using the matlab command
P = my_mult(L,K) ;
% Display the result
disp(P)

% The following is what you would usually do to multiply matrices. Compare
% the two results
disp(L*K)
