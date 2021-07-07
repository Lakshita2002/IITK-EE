clc; close all; clear all;
%% Solving L1 Ex 8
figure(1);
% first by Euler approximation
x(1) = 0.5; h = 0.1; t = 0; time(1)=0;
for i=1:1000
    x(i+1) = x(i) + h*(-x(i) + x(i)*x(i));
    t = t+h;
    time(i+1) = t;
end
plot(time, x);
hold on;
% Now using the Runge-Kutta 4th Order Algorithm
x(1)=0.5;
h=0.1; t=0; time(1)=0;
for i=1:1000
    m0 = -x(i) + x(i)^2;
    m1 = -(x(i)+h*m0/2) + (x(i)+h*m0/2)^2;
    m2 = -(x(i)+h*m1/2) + (x(i)+h*m0/2)^2;
    m3 = -(x(i)+h*m2) + (x(i)+h*m2)^2;
    x(i+1) = x(i) + h*(m0+2*m1+2*m2+m3)/6;
    t=t+h;
    time(i+1)=t;
end
plot(time, x);
hold on;
% Now using the ode45 Solver
tspan = [0 100];
x0 = 0.5;
[t x] = ode45(@(t,x) -x+x^2, tspan, x0);
plot(t, x);
hold off;
grid on;
legend('Euler', 'Runge-Kutta', 'ODE45');
title('Joint Plot');
ylabel('Magnitude');
xlabel('Time');
%% Solving L3 Ex 7.1 Q2-(a)
s = tf('s');
G = 1/(s*(s+1));
D(1) = (s+2)/2;
D(2) = 2*(s+2)/(s+4);
D(3) = 5*(s+2)/(s+10);
D(4) = 5*(s+2)*(s+0.1)/((s+10)*(s+0.01));
for i=1:4
    sys(i) = feedback(G*D(i), 1);
    stepplot(sys(i)); hold on;
    S = stepinfo(sys(i));       % Remove semicolon to get all info
end
hold off;
legend('sys1', 'sys2', 'sys3', 'sys4');
grid on;
title('Comparing Controllers');
ylabel('Magnitude');
xlabel('Time');
%% Finding response to cutom input
t = 0:0.1:100;
input = t;      % for ramp input
sys = tf(1/((s+1)*(5*s+1)));
[x t] = lsim(sys, input, t);
plot(t, x); hold on;
plot(t, input); hold off;
title('Ramp Response');
ylabel('Magnitude');
xlabel('Time');
grid on;
%% Solving L3 Ex 7.1 Q1-(d)
s = tf('s');
G = 1/((s+1)*(5*s+1));
C(1) = 19 + 4*s/19 + 1/(2*s);
C(2) = 19 + 4*s/19;
C(3) = 19;
figure(1);
for i=1:3
    sys(i) = feedback(G*C(i), 1);
    stepplot(sys(i));   hold on;
    stepinfo(sys(i))
end
hold off;
title('Step Response');
xlabel('Time');
ylabel('Magnitude');
legend('PID', 'PD', 'P')
figure(2);
t = 0:0.1:100;
plot(t, t, '.');    hold on;
for i=1:3
    [x t] = lsim(sys(i), t, t); 
    plot(t, x, '-'); hold on;
end
hold off;
title('Ramp Response');
xlabel('Time');
ylabel('Magnitude');
legend('input', 'PID', 'PD', 'P')