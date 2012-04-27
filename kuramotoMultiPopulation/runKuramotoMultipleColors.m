%% Script to integrate kuramoto equations and plot the results

%parameters
p.K = -1.5; % coupling strength
p.N = 2; %number of oscillators
Omega = 3; %mean frequency
a = Omega; b =Omega+5; %range of oscillator frequencies
p.w = a + (b-a).*rand(p.N,1); %distribution of osc frequencies
nIters = 20000;
tBegin = 0;
tEnd = 200;

% %adjacency matrix
% nPerColor = [10 10 10 10 10 10 10 10]; %number of neurons associated with each color
% 
% baseLNLN = [0 1 1 1 1 1 0 0; % the connectivity between colored groups
%             1 0 1 1 1 0 1 0;
%             1 1 0 1 1 1 0 1;
%             1 1 1 0 1 0 1 0;
%             1 1 1 1 0 1 0 0;
%             1 0 1 0 1 0 0 0;
%             0 1 0 1 0 0 0 0;
%             0 0 1 0 0 0 0 0];
% 
% baseAdjList =  [1,2; %the connections in the baseLNLN adjacency matrix is zero or unity
%                 2,3; % this list tells you which pairs of groups (colors) do not connect
%                 3,4; % with each other in an all-to-all manner
%                 4,5]
%             
% pConn = [0.8; %probability of connection between the groups listed in baseAdjList
%         0.8;
%         0.8;
%         0.8];

nPerColor = [1 1]
baseLNLN = [0 1; 
            1 0];
% baseAdjList = [];
% pConn = [];
        

p.G = graphGenerator(nPerColor,baseLNLN);%,'baseAdjList',baseAdjList,'pConn',pConn); %generate the g


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