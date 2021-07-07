clc; clear all; close all;
%% Storing given data
Mp = ;                                                                     % given maximum peak overshoot
zeta = ;                                                                   % given damping coefficient
set_time = ;                                                               % given maximum settling time
s = tf('s');
gs = ;                                                                     % given open loop transfer functon
%% Finding parameters and dominant poles by given specifications
zeta = sqrt((log(Mp)^2/(pi^2+(log(Mp))^2)));                               % Mp = exp((-pi*zeta)/(sqrt(1-zeta^2)))
w_n = 4/(set_time*zeta);                                                   % settling time = 4/(w_n*zeta)
d_p1 = -w_n*zeta + j*w_n*sqrt(1-zeta^2);                                   % desired dominant pole 1
d_p2 = -w_n*zeta - j*w_n*sqrt(1-zeta^2);                                   % desired dominant pole 2
d_p1 = -1+j;
P = pole(gs); Z = zero(gs);                                                % to store the open-loop poles and zeroes respectively
m = length(Z); n = length(P);                                              % to store the number of zeroes and poles respectively
%% Angle contribution by desired dominant poles and compensator
% angle contributed = (sum of angles made with the open-loop zeroes) - (sum of angles made with the open-loop poles)
phi = sum(angle(d_p1-Z)) - sum(angle(d_p1-P));
%phi*180/pi
%% Designing Lead Compensator
cz = ;                                                                     % choosing compensator zero near origin
phi = phi + angle(d_p1-cz);                                                % adding angle made by the dominant pole with the compensator zero
cp_angle = phi + pi;                                                       % angle made by the dominant pole with the compensator pole
cp = real(d_p1)-(imag(d_p1)/tan(cp_angle));                                % to find the compensator pole
cs = tf((s-cz)/(s-cp));                                                    % compensator (without K)
ls = cs*gs;                                                                % loop tranfer function (without K)
K = real(evalfr(-1/ls, d_p1));                                             % to find the value of gain in compensator, K = 1/|L(s)|

ss = feedback(K*ls, 1);
%step(ss);
%% Designing Lag Compensator
cp = ;                                                                     % choosing compensator pole near origin
phi = phi - angle(d_p1-cp);                                                % adding angle made by the dominant pole with the compensator pole
cz_angle = - phi;                                                          % angle made by the dominant pole with the compensator zero
cz = real(d_p1)-(imag(d_p1)/tan(cz_angle));                                % to find the compensator zero
cs = tf((s-cz)/(s-cp));                                                    % compensator (without K)
ls = cs*gs;                                                                % loop tranfer function (without K)
K = real(evalfr(-1/ls, d_p1));                                             % to find the value of gain in compensator, K = 1/|L(s)|

ss = feedback(K*ls, 1);
%step(ss);