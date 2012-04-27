%script to generate a digraph from the template


nPerColor = [10 10 10 10 10 10 10 10];

baseLNLN = [0 1 1 1 1 1 0 0;
            1 0 1 1 1 0 1 0;
            1 1 0 1 1 1 0 1;
            1 1 1 0 1 0 1 0;
            1 1 1 1 0 1 0 0;
            1 0 1 0 1 0 0 0;
            0 1 0 1 0 0 0 0;
            0 0 1 0 0 0 0 0];

% baseAdjList =  [1,2;
%                 2,3;
%                 3,4;
%                 4,5]
% pConn = [0.8;
%         0.8;
%         0.8;
%         0.8];
    
baseAdjList = [1,2]
pConn = 0.8;
G = TemplateGraphGenerator(nPerColor,baseLNLN);

for ii = 1:size(baseAdjList,1)
    %determine which block to delete connections from
    in = baseAdjList(ii,2);
    out = baseAdjList(ii,1);
    r = [sum(nPerColor(1:in-1))+1,sum(nPerColor(1:in))]
    c = [sum(nPerColor(1:out-1))+1,sum(nPerColor(1:out))]
    
    rnum = rand(diff(r)+1,diff(c)+1);
    rnum = double(rnum > pConn(ii));
    G(r(1):r(2),c(1):c(2)) = rnum.*G(r(1):r(2),c(1):c(2));
end

%printing to file
nLN = sum(nPerColor);
nPN = 1;
LNLN = G;
LNPN = zeros(nLN,nPN);
PNLN = zeros(nLN,nPN);
PNPN = zeros(nPN,nPN);
PN = zeros(nPN);
LN = ones(nLN,1);

LNLN = LNLN(:); LNPN = LNPN(:);
PNPN = PNPN(:); PNLN = PNLN(:);

save C_LNLN.txt LNLN -ascii;
save C_LNPN.txt LNPN -ascii;
save C_PNLN.txt PNLN -ascii;
save C_PNPN.txt PNPN -ascii;
save C_LN.txt LN -ascii;
save C_PN.txt PN -ascii;