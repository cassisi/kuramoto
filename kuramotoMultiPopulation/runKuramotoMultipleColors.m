%% Script to integrate kuramoto equations and plot the results

%parameters
%---------------------------------------------------------------
p.K = 4.5; % coupling strength
nIters = 20000; %number of iterations
tBegin = 0; 
tEnd = 200; 

%network parameters
nPerColor = [10 10];
p.N = sum(nPerColor); %number of oscillators
baseLNLN = [0 1; 
            1 0];

%oscillator frequency        
Omega = 3; %mean frequency
a = Omega; b =Omega; %range of oscillator frequencies
p.w = a + (b-a).*rand(p.N,1); %distribution of osc frequencies
%---------------------------------------------------------------


%construct graph
p.G = graphGenerator(nPerColor,baseLNLN);%,'baseAdjList',baseAdjList,'pConn',pConn); %generate the g

%initial condition
thetaInit = -pi + 2*pi.*rand(p.N,1); %uniform distribution \in [-pi,pi]

%integration
[t,theta] = rk4(@kuramotoMultipleColors,tBegin, tEnd,thetaInit,nIters,p);

theta = mod(theta,2*pi); %theta is in the interval [0 2pi]
theta = theta - pi; %shift the interval to [-pi pi]

figure; imagesc(t,[1:p.N],theta)
%% movie
figure;
for ii = 1:nIters
    x = cos(theta(:,ii));
    y = sin(theta(:,ii));
    mTheta(ii) = circ_mean(theta(:,ii)); %circular mean of theta
    rTheta(ii) = 1 - circ_std(theta(:,ii)); %circular standard deviation of theta
    mx = rTheta(ii)*cos(mTheta(ii)); my = rTheta(ii)*sin(mTheta(ii));
    
    plot(x,y,'.k'); hold on
    line([0,mx],[0,my],'Color','r','LineWidth',2); hold off
    axis([-1 1 -1 1]); axis square
    pause(0.2)
end 

% movie(M,1)