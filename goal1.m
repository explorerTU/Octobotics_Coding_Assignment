clear all, close all, clc
% x = cart position
% m = pendulum mass
% M = cart mass
% L = pendulum length
% g = gravitational acceleration
% d = friction damping
% u = control force applied to the cart

m = 0.2;
M = 0.05;
L = 300;
g = -10;
d = 1;

b = -1; % pendulum down (b=-1)

A = [0 1 0 0;
    0 -d/M b*m*g/M 0;
    0 0 0 1;
    0 -b*d/(M*L) -b*(m+M)*g/(M*L) 0];
B = [0; 1/M; 0; b*1/(M*L)];
eig(A)

rank(ctrb(A,B))

p = [-.3; -.4; -.5; -.6];

K = place(A,B,p);

tspan = 0:.001:30;
if(b==-1)
    y0 = [0;0;0;0];
    [t,y] = ode45(@(t,y)pendulumwithcart(y,m,M,L,g,d,-K*(y-[4;0;0;0])),tspan,y0);
elseif(b==1)
    y0 = [-3;0;pi+.1;0];
    [t,y] = ode45(@(t,y)pendulumwithcart(y,m,M,L,g,d,-K*(y-[1;0;pi;0])),tspan,y0);
else
end

for k=1:100:length(t)
    pendulum_figure(y(k,:),m,M,L);  
end  
