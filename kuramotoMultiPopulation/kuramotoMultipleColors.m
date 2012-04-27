function thetaDot = kuramotoMultipleColors(t,theta,p)
%equations for a system of weakly coupled kuramoto oscillators
% inputs, t = time, theta = oscillator phase [nOscillators x 1]
%         p.w = frequencies [nOscillators x 1], p.K = coupling strength
%         p.N = number of oscillators
%outputs, thetadot (input to rk4.m)
%
%Kuramoto equations are given by
%\dot{\theta_{i}} = \omega_{i} + (K/N)*\sum_{j=1}^{j=N} sin(\theta_{j}-\theta_{i})

[theta_j,theta_i] = meshgrid(theta);
thetaDot = p.w + ((p.K*p.G./p.N)*sin(theta_j-theta_i))*ones(p.N,1);