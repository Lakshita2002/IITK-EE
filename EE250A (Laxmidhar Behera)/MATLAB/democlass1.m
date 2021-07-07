clc; close all; clear all;
%% Solving L1 Ex 4.2.2 Q2-(a)
s = tf('s');
sys = (10*(s+1))/(s*(s+4)*(s+6));
%sys = tf([10 10], [1 10 24 0]);     % defining transfer function in 1 line
stepplot(sys);      % to straightaway plot the step response
grid on;
%% Solving L1 Ex 4.2.2 Q2-(b)
syms s;
F = 10*(s+1)/(s*(s+4)*(s+6));
ilaplace(F/s);                  % to find the step response in time domain
%% Solving L1 Ex 4.2.2 Q2-(c)
syms s;
F = (s+1)/(s*(s+3)*(s^2+4*s+8));
ilaplace(F);
%% Solving L1 Ex 4.2.2 Q3-(a)
syms y(t);
dy = diff(y,t);
ode = diff(y,t,2) - 2*diff(y,t) + 4*y == 0;
cond1 = y(0)==1;
cond2 = dy(0)==2;
cond = [cond1 cond2];
ysol(t) = dsolve(ode,cond);     
%% Solving L1 Ex 4.2.2 Q3-(b)
syms y(t);
dy = diff(y,t);
ode = diff(y,t,2) + 3*y == sin(t);
cond = [y(0)==1 dy(0)==2];      % a shortcut for writing conditions list
ysol(t) = dsolve(ode, cond);    
%% Solving L1 Ex 4.2.2 Q3-(c)
syms y(t);
dy = diff(y,t);
ode = diff(y,t,2) + y == t;
cond = [y(0)==1 dy(0)==-1];     
ysol(t) = dsolve(ode,cond);    
%% Solving L1 Ex 4.2.2 Q4-(a)
num = 2;
den = [1 2 0];
[r, p, k] = residue(num, den);   % to find the residues for partial fractions' process
syms s;
F = 2/(s*(s+2));
ilaplace(F);
%% Solving L1 Ex 4.2.2 Q4-(b)
syms s;
F  = (3*s+2)/(s^2+4*s+20) ;
ilaplace(F);
%% Solving L1 Ex 4.2.2 Q4-(c)
syms s;
F = 1/(s^2+4);
ilaplace(F);
%% Solving L1 Ex 4.2.2 Q4-(d)
syms s;
F = (s+1)/(s^2);
ilaplace(F);
%% Solving L1 Ex 8
% first by Euler approximation
x(1) = 0.5; h = 0.1; t = 0; time(1)=0;
for i=1:1000
    x(i+1) = x(i) + h*(-x(i) + x(i)*x(i));
    t = t+h;
    time(i+1) = t;
end
plot(time, x);