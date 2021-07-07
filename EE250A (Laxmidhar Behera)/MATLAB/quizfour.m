clc; clear all; close all;

a = -50*j*(20+2*j)/(20-48*j)
a = a/(a+10 + 4*j)
sqrt(real(a)^2 + imag(a)^2)
angle(a)*180/pi