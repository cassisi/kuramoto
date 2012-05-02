%script to generate a digraph from the template


nPerColor = [10 10 10 10 10 10 10 20]; %number of neurons associated with each color

baseLNLN = [0 1 1 1 1 1 0 0; % the connectivity between colored groups
            1 0 1 1 1 0 1 0;
            1 1 0 1 1 1 0 1;
            1 1 1 0 1 0 1 0;
            1 1 1 1 0 1 0 0;
            1 0 1 0 1 0 0 0;
            0 1 0 1 0 0 0 0;
            0 0 1 0 0 0 0 0];
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
% 
baseLNLN = [1 0; 0 1];
nPerColor = [1 1]
G = graphGenerator(nPerColor,baseLNLN);%,'baseAdjList',baseAdjList,'pConn',pConn); %generate the graph