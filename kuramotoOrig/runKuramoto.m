%% Script to integrate kuramoto equations and plot the results

%parameters
p.K = -1.5; % coupling strength
p.N = 25; %number of oscillators
Omega = 3; %mean frequency
a = Omega; b =Omega+5; %range of oscillator frequencies
p.w = a + (b-a).*rand(p.N,1); %distribution of osc frequencies
nIters = 20000;
tBegin = 0;
tEnd = 200;

%initial condition
thetaInit = -pi + 2*pi.*rand(p.N,1); %uniform distribution \in [-pi,pi]

%integration
[t,theta] = rk4(@kuramoto,tBegin, tEnd,thetaInit,nIters,p);

theta = mod(theta,2*pi); %theta is in the interval [0 2pi]
theta = theta - pi; %shift the interval to [-pi pi]

[w,ind] = sort(p.w);
theta = theta(ind,:);

figure; imagesc(t,[1:p.N],theta)
%% movie

for ii = 1:nIters
    x = cos(theta(:,ii));
    y = sin(theta(:,ii));
    mTheta(ii) = circ_mean(theta(:,ii)); %circular mean of theta
    rTheta(ii) = 1 - circ_std(theta(:,ii)); %circular standard deviation of theta
    mx = rTheta(ii)*cos(mTheta(ii)); my = rTheta(ii)*sin(mTheta(ii));
    
    plot(x,y,'Color',k); hold on
    line([0,mx],[0,my],'Color','r','LineWidth',4); hold off
    axis([-1 1 -1 1]); axis square
    pause(0.2)
end 

% movie(M,1)