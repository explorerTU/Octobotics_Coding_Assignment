clear all, close all, clc

% x = cart position
% m = pendulum weight
% M = cart wight
% L = pendulum length
% g = gravitational acceleration
% d = friction damping
% u = control force applied to the cart

m = 1;
M = 5;
L = 2;
g = -10;
d = 1;

tspan = 0:.1:30;
y0 = [0; 0; pi; .5];
[t,y] = ode45(@(t,y)pendulumwithcart(y,m,M,L,g,d,0),tspan,y0);

for k=1:length(t)
    pendulum(y(k,:),m,M,L);
end

