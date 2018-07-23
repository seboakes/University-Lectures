% Set up training data

numPts=51;
x=linspace(-10,10,numPts)';
y= -2*x - x.^2;
data=[x y];

% Split into training and validation data
trndata=data(1:2:numPts,:);
chkdata=data(2:2:numPts,:);

% Specify Membership Functions
 numMFs=5;
 mfType='gbellmf';
 
% Generate initial FIS
 fismat=(genfis1(trndata,numMFs,mfType))
 numEpochs=40;
 
% Train the FIS
[fismat1,trnErr,ss,fismat2,chkErr]=anfis(trndata,fismat,numEpochs,NaN,chkdata);
%Compare training and checking data to the fuzzy approximation:
anfis_y=evalfis(x(:,1),fismat1);

plot(trndata(:,1),trndata(:,2),'o',chkdata(:,1),chkdata(:,2),'x',x,anfis_y,'-')

hold on;
plot(x,y)

