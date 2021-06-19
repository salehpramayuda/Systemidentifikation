clc; clear;

syms q_1 real
A = 1 - 0.9*q_1;
B = 0.5;
C = 1 + 0.5*q_1;
D = 1 - q_1;
d = 1;
i = 1;

[E, F, G, H] = einSchrittVoraus(B, A, C, D, d, i);
E
F
G
H