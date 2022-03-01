clear all, close all, clc

m = 1;
M = 3;
L = 2;
g = -10;
d = 1;

b = 1; % pendulum down (b=-1)

A = [0 1 0 0;
    0 -d/M b*m*g/M 0;
    0 0 0 1;
    0 -b*d/(M*L) -b*(m+M)*g/(M*L) 0];
B = [0; 1/M; 0; b*1/(M*L)];

eig(A)
det(ctrb(A,B))

%%  Design LQR controller
Q = [1 0 0 0;
    0 1 0 0;
    0 0 10 0;
    0 0 0 100];
R = .001;

K = lqr(A,B,Q,R);

%% Simulate closed-loop system
tspan = 0:.001:20;
x0 = [-1; 0; pi+.1; 0];  % initial condition 
wr = [1; 0; pi; 0];      % reference position
u=@(x)-K*(x - wr);       % control law
[t,x] = ode45(@(t,x)pendulumwithcart(x,m,M,L,g,d,u(x)),tspan,x0);

for k=1:100:length(t)
    pendulum(x(k,:),m,M,L);
end

%%
plot(t,x,'LineWidth',2); hold on
l1 = legend('x','v','\theta','\omega')
set(l1,'Location','SouthEast')
set(gcf,'Position',[100 100 500 200])
xlabel('Time')
ylabel('State')
grid on
set(gcf,'PaperPositionMode','auto')
