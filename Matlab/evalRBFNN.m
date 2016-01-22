function [CM, OUTPUT, TARGET_TEST] = evalRBFNN(STARTING_POINT, SPAN, TEST__START, TEST_SPAN, GOAL, SPREAD_CONSTANT, MN, DF)
% this returns the confusion matrix for the given evalution
%     ALL_INPUT = load('Data/DATA.mat', 'INPUT');
%     ALL_TARGET = load('Data/DATA.mat', 'TARGET');

    ALL_INPUT = load('Data/equalizedDATA.mat', 'equalizedINPUT');
    ALL_TARGET = load('Data/equalizedDATA.mat', 'equalizedTARGET');
    
    ALL_INPUT = ALL_INPUT.equalizedINPUT;
    ALL_TARGET = ALL_TARGET.equalizedTARGET;
    LENGTH = length(ALL_TARGET);
    
    disp(TEST__START);
    disp(TEST_SPAN);
    
    START = int16(LENGTH * STARTING_POINT);
    if START == 0
        START = 1;
    end
    END = int16(START + SPAN);
    TEST_START = START + TEST__START;
    TEST_END = TEST_START + TEST_SPAN;
    
    disp(TEST_START);
    disp(TEST_END);
    
    INPUT_TRAIN = horzcat(ALL_INPUT(:, START:TEST_START - 1), ALL_INPUT(:, TEST_END:END));
    TARGET_TRAIN = horzcat(ALL_TARGET(START:TEST_START - 1), ALL_TARGET(TEST_END:END));
    disp(size(INPUT_TRAIN));
    disp(size(TARGET_TRAIN));
    
    
    if nargin < 8
     DF = 25;
        if nargin < 7
            MN = length(TARGET_TRAIN);
        end
    end

    INPUT_TEST = ALL_INPUT(:, TEST_START: TEST_END - 1);
    TARGET_TEST = ALL_TARGET(TEST_START: TEST_END - 1);
    
    disp(size(INPUT_TEST));
    disp(size(TARGET_TEST));

    NN = newrb(INPUT_TRAIN, TARGET_TRAIN, GOAL, SPREAD_CONSTANT, MN, DF);
    OUTPUT = sim(NN, INPUT_TEST);
    [dummy,CM] = confusion(TARGET_TEST,OUTPUT);
    save(strcat('bbDATA', num2str(TEST_SPAN)), 'TARGET_TEST', 'OUTPUT');
    disp('saved once');
end

