% defining parameters for the simulation

tspan=[0 20];  % simulation time window

% rand initialiation of values 
y0 = rand(1,8);

[t,y]=ode45(@(t,y)cpg(t,y),tspan,y0);
figure;plot(t,y)