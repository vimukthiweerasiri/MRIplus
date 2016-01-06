function [CM] = evalRBFNN(STARTING_POINT, SPAN, TEST_START, TEST_SPAN, GOAL, SPREAD_CONSTANT, MN, DF)
% this returns the confusion matrix for the given evalution
    ALL_INPUT = load('Data/DATA.mat', 'INPUT');
    ALL_TARGET = load('Data/DATA.mat', 'TARGET');
    ALL_INPUT = ALL_INPUT.INPUT;
    ALL_TARGET = ALL_TARGET.TARGET;
    LENGTH = length(ALL_TARGET);
    
    START = int16(LENGTH * STARTING_POINT);
    END = int16(START + SPAN);
    TEST_START = START + TEST_START;
    TEST_END = TEST_START + TEST_SPAN;
    
    disp(START);
    disp(TEST_START);
    disp(TEST_END);
    disp(END);
    
    INPUT_TRAIN = horzcat(ALL_INPUT(:, START:TEST_START - 1), ALL_INPUT(:, TEST_END:END));
    TARGET_TRAIN = horzcat(ALL_TARGET(START:TEST_START - 1), ALL_TARGET(TEST_END:END));
    
    
    if nargin < 8
     DF = 25;
        if nargin < 7
            MN = TEST_START - START + 1;
        end
    end

    INPUT_TEST = ALL_INPUT(:, TEST_START: TEST_END - 1);
    TARGET_TEST = ALL_TARGET(TEST_START: TEST_END - 1);

    NN = newrb(INPUT_TRAIN, TARGET_TRAIN, GOAL, SPREAD_CONSTANT, MN, DF);
    OUTPUT = sim(NN, INPUT_TEST);
    [dummy,CM] = confusion(TARGET_TEST,OUTPUT);
end

