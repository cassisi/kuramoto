%Script to integrate kuramoto equations and plot the results

%parameters
p.K = 3; % coupling strength
p.N = 5; %number of oscillators
Omega = 2; %mean frequency
a = 0; b = Omega+2; %range of oscillator frequencies
p.w = a + (b-a).*rand(p.N,1); %distribution of osc frequencies
nIters = 1000;

%initial condition
thetaInit = -pi + 2*pi.*rand(p.N,1); %uniform distribution \in [-pi,pi]

%integration
[t,theta] = rk4(@kuramoto,0, 100,thetaInit,nIters,p);

%plotting
theta = mod(theta,2*pi); %theta is in the interval [0 2pi]
theta = theta - pi; %shift the interval to [-pi pi]

for ii = 1:nIters
    x = cos(theta(:,ii));
    y = sin(theta(:,ii));
    mTheta(ii) = circ_mean(theta(:,ii)); %circular mean of theta
    rTheta(ii) = 1 - circ_std(theta(:,ii)); %circular standard deviation of theta
    mx = rTheta(ii)*cos(mTheta(ii)); my = rTheta(ii)*sin(mTheta(ii));
    
    plot(x,y,'Color',rand(p.N,3)); hold on
    line([0,mx],[0,my],'Color','r','LineWidth',4); hold off
    axis([-1 1 -1 1]); axis square
    pause(0.2)
end 

% movie(M,1)