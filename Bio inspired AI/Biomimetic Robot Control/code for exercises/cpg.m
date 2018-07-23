function dydt = cpg(t, y)  

freq = 2;
%fixed parameters
alpha = 5;
beta = 50;
miu = 1;
b = 1;

%initial conditions / last values
xi     = y(1);
yi     = y(2);
xj     = y(3);
yj     = y(4);
xk     = y(5);
yk     = y(6);
xl     = y(7);
yl     = y(8);

ri = sqrt(xi^2 + yi^2);
rj = sqrt(xj^2 + yj^2);
rk = sqrt(xk^2 + yk^2);
rl = sqrt(xl^2 + yl^2);

%frequency for all oscillators
w_swing = 1;
w_stance = freq*w_swing;

%Coupling matrix, that determines a walking gate for
%a quadruped robot. 
k = [ 0, -1, -1,  1;
     -1,  0,  1, -1;
     -1,  1,  0, -1;
      1, -1, -1,  0];

  
  
%Hopf oscillator 1
omegai = w_stance/(exp(-b*yi)+1) + w_swing/(exp(b*yi)+1);
xi_dot = alpha*(miu - ri^2)*xi - omegai*yi;
yi_dot = beta*(miu - ri^2)*yi + omegai*xi + k(1,2)*yj + k(1,3)*yk + k(1,4)*yl;

%Hopf oscillator 2
omegaj = w_stance/(exp(-b*yj)+1) + w_swing/(exp(b*yj)+1);
xj_dot = alpha*(miu - rj^2)*xj - omegaj*yj;
yj_dot = beta*(miu - rj^2)*yj + omegaj*xj + k(2,1)*yi + k(2,3)*yk + k(2,4)*yl;

%Hopf oscillator 3
omegak = w_stance/(exp(-b*yk)+1) + w_swing/(exp(b*yj)+1);
xk_dot = alpha*(miu - rk^2)*xk - omegak*yk;
yk_dot = beta *(miu - rk^2)*yk + omegak*xk + k(3,4)*yl + k(3,2)*yj + k(3,1)*yi;

%Hopf oscillator 4
omegal = w_stance/(exp(-b*yl)+1) + w_swing/(exp(b*yl)+1);
xl_dot = alpha*(miu - rl^2)*xl - omegal*yl;
yl_dot = beta *(miu - rl^2)*yl + omegal*xl + k(4,3)*yk + k(4,2)*yj + k(4,1)*yi; 

%Outputs
dydt(1,1) = xi_dot;
dydt(2,1) = yi_dot;
dydt(3,1) = xj_dot;
dydt(4,1) = yj_dot;
dydt(5,1) = xk_dot;
dydt(6,1) = yk_dot;
dydt(7,1) = xl_dot;
dydt(8,1) = yl_dot;