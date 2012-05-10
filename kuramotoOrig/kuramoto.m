function thetaDot = kuramoto(t,theta,p)
%equations for a system of weakly coupled kuramoto oscillators
% inputs, t = time, theta = oscillator phase [nOscillators x 1]
%         p.w = frequencies [nOscillators x 1], p.K = coupling strength
%         p.N = number of oscillators
%outputs, thetadot (input to rk4.m)
%
%Kuramoto equations are given by
%\dot{\theta_{i}} = \omega_{i} + (K/N)*\sum_{j=1}^{j=N} sin(\theta_{j}-\theta_{i})

[theta_i,theta_j] = meshgrid(theta);
interactionTerm = sum(sin(theta_j-theta_i),1)';
thetaDot = p.w + p.K/p.N*interactionTerm;