function G = graphGenerator(nPerColor,baseLNLN,varargin)
%--------------------------------------------------------------------------
%function to generate a template network that has the coloring properties
%of the network specified by baseLNLN

%example of input to the function
% nPerColor = [10 10 10 10 10 10 10 20]; %number of neurons associated with each color
%
%
% baseLNLN = [0 1 1 1 1 1 0 0;  % the connectivity between colored groups
%             1 0 1 1 1 0 1 0;
%             1 1 0 1 1 1 0 1;
%             1 1 1 0 1 0 1 0;
%             1 1 1 1 0 1 0 0;
%             1 0 1 0 1 0 0 0;
%             0 1 0 1 0 0 0 0;
%             0 0 1 0 0 0 0 0];
% baseAdjList =  [1,2; %the connections in the baseLNLN adjacency matrix is zero or unity
%                 2,3; % this list tells you which pairs of groups (colors) do not connect
%                 3,4; % with each other in an all-to-all manner
%                 4,5]
%
% pConn = [0.8; %probability of connection between the groups listed in baseAdjList
%         0.8;
%         0.8;
%         0.8];

%--------------------------------------------------------------------------

%default parameters
baseAdjList = []; %assume all-all connections between connected groups determined by baseLNLN
pConn = [];

if nargin > 2
    for ii = 1:2:length(varargin)
        tmp1 = varargin{ii+1};
        eval([varargin{ii}, '= tmp1;']);
    end
end


nLN = sum(nPerColor); %number of neurons
nColors = length(nPerColor); %number of colors
m = max(nPerColor(:)); %max number of neurons in any group
tmp = ones(m);
G = kron(baseLNLN,tmp);%generate base matrix

%now delete rows and columns to make the number of neurons associated with
%the ith color to ne nPercolor(i)
nDelete = m - nPerColor;
tmp = 1:m*nColors; tmp = reshape(tmp,m,nColors);
% tmp = 1:m^2; tmp = reshape(tmp,m,m);
deleteRowsCols = [];
for ii = 1:size(baseLNLN,2)
    deleteRowsCols = [deleteRowsCols;tmp(1:nDelete(ii),ii)];
end
G(deleteRowsCols,:) = [];
G(:,deleteRowsCols) = [];

%now run through the probability of connection between different colors
if ~isempty(baseAdjList)
    for ii = 1:size(baseAdjList,1)
        %determine which block to delete connections from
        in = baseAdjList(ii,2);
        out = baseAdjList(ii,1);
        r = [sum(nPerColor(1:in-1))+1,sum(nPerColor(1:in))]
        c = [sum(nPerColor(1:out-1))+1,sum(nPerColor(1:out))]
        
        rnum = rand(diff(r)+1,diff(c)+1);
        rnum = double(rnum < pConn(ii));
        G(r(1):r(2),c(1):c(2)) = rnum.*G(r(1):r(2),c(1):c(2));
    end
end