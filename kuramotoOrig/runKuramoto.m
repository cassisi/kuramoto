%% Script to integrate kuramoto equations and plot the results

%parameters
p.K = 0.5; % coupling strength
p.N = 100; %number of oscillators
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
figure
x = cos(theta);
y = sin(theta);
mTheta = circ_mean(theta,[],1); %circular mean of theta
rTheta = 1 - circ_std(theta,[],[],1); %circular standard deviation of theta
mx = rTheta.*cos(mTheta); my = rTheta.*sin(mTheta);

for ii = 1:nIters
    
    plot(x(:,ii),y(:,ii),'.k'); hold on
    line([0,mx(ii)],[0,my(ii)],'Color','r','LineWidth',4); hold off
    axis([-1 1 -1 1]); axis square
    drawnow
    %     pause(0.2)
end

% movie(M,1)