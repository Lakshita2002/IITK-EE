clc; clear all; close all;
%% ROOT LOCUS
s = tf('s');
g = (s+2)/(s*(s+10)*(s^2-1));
figure(1);
rlocus(g);
grid on;
%% Find the centroid
P = pole(g);        % the poles of the open loop system 
Z = zero(g);        % the zeros of the open loop system        
m = length(Z);      % the number of zeros
n = length(P);      % the number of poles
centroid = (sum(P)-sum(Z))/(n-m);       
for i = 1:n-m       % For Asymptotic Angles
    phi(i) = (2*i-1)*180/(n-m)
end
hold on;
plot(centroid,0);
for i=1:n-m
    if(phi(i)<=90 || phi(i)>=270)
        x_step = centroid:40;
        plot(x_step, tand(phi(i))*(x_step-centroid), '--k');
    else
        x_step = -40:centroid;
        plot(x_step, tand(phi(i))*(x_step-centroid), '--k');
    end        
end

