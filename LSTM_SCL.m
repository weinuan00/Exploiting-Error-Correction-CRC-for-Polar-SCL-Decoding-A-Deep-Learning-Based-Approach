clear;
%load('xunlian_seg1_30_snr15_6607.mat');
load('xunlianseg128_1_40_snr15_15254.mat');
xunlian_n=15000;
test_n=12000; 
llr_tab4=abs(llr_tab4);
ee=zeros(xunlian_n,1);
ss=cell(xunlian_n,1);
for ii2=1:xunlian_n
    %ss{ii2}=[llr_tab4(:,:,ii2);soft_tab4(:,:,ii2);s_tab4(ii2,:),zeros(1,18)];
    ss{ii2}=[llr_tab4(:,:,ii2);s_tab4(ii2,:),zeros(1,23)];
end

XTrain = ss(1:test_n);
XValidation  = ss(test_n+1:xunlian_n);
train_y = ep_fenlei(1:test_n);
YValidation  = ep_fenlei(test_n+1:xunlian_n);
YTrain=categorical(train_y);
YValidation=categorical(YValidation);

figure
plot(XTrain{3}')

xlabel("Code Step")
title("Training Observation 1")
legend("Feature " + string(1:9),'Location','northeastoutside')


inputSize = 9;
numHiddenUnits = 260;
numClasses = 40;

layers = [ ...
    sequenceInputLayer(inputSize)
    %bilstmLayer(numHiddenUnits,'OutputMode','sequence')
    bilstmLayer(numHiddenUnits,'OutputMode','last')
    fullyConnectedLayer(numClasses)
    dropoutLayer(0.05)   
    fullyConnectedLayer(numClasses)   
    softmaxLayer
    classificationLayer]

maxEpochs = 40;
miniBatchSize = 1000;

options = trainingOptions('adam', ...
    'ExecutionEnvironment','cpu', ...
    'InitialLearnRate', 0.001, ...
    'LearnRateSchedule','piecewise', ...
    'LearnRateDropPeriod',20, ...
    'GradientThreshold',1, ...
    'MaxEpochs',maxEpochs, ...
    'MiniBatchSize',miniBatchSize, ...
    'ValidationData',{XValidation,YValidation}, ...
    'ValidationFrequency',30, ...
    'Plots','training-progress', ...
    'Verbose',false);

net = trainNetwork(XTrain,YTrain,layers,options);

trainPred = classify(net,XTrain);
LSTMAccuracy = sum(trainPred == YTrain)/numel(YTrain)*100
figure
ccLSTM = confusionchart(YTrain,trainPred);
ccLSTM.Title = 'Confusion Chart for LSTM';
ccLSTM.ColumnSummary = 'column-normalized';
ccLSTM.RowSummary = 'row-normalized';


[testPred,POSTERIOR] = classify(net,XValidation);
LSTMAccuracy2 = sum(testPred == YValidation)/numel(YValidation)*100