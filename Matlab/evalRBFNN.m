function [CM] = evalRBFNN(STARTING_POINT, SPAN, TEST_PERCENTAGE, GOAL, SPREAD_CONSTANT, MN, DF)
% this returns the confusion matrix for the given evalution
    ALL_INPUT = load('Data/DATA.mat', 'INPUT');
    ALL_TARGET = load('Data/DATA.mat', 'TARGET');
    ALL_INPUT = ALL_INPUT.INPUT;
    ALL_TARGET = ALL_TARGET.TARGET;
    LENGTH = length(ALL_TARGET);
    if SPAN < 1
        SPAN = LENGTH * SPAN;
    end
    
    START = int16(LENGTH * STARTING_POINT);
    END = int16(START + SPAN);
    TEST_START = int16(END - SPAN * TEST_PERCENTAGE);
    
    INPUT_TRAIN = ALL_INPUT(:, START:TEST_START);
    TARGET_TRAIN = ALL_TARGET(START:TEST_START);
    
    if nargin < 7
     DF = 25;
        if nargin < 6
            MN = TEST_START - START + 1;
        end
    end

    INPUT_TEST = ALL_INPUT(:, TEST_START + 1: END);
    TARGET_TEST = ALL_TARGET(TEST_START + 1: END);

    NN = newrb(INPUT_TRAIN, TARGET_TRAIN, GOAL, SPREAD_CONSTANT, MN, DF);
    OUTPUT = sim(NN, INPUT_TEST);
    [dummy,CM] = confusion(TARGET_TEST,OUTPUT);
end

