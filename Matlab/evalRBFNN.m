function evalRBFNN(STARTING_POINT, SPAN, TEST_PERCENTAGE, GOAL, SPREAD_CONSTANT)
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
    
    disp(START);
    disp(TEST_START);
    
    
    INPUT_TEST = ALL_INPUT(:, TEST_START + 1: END);
    TARGET_TEST = ALL_TARGET(TEST_START + 1: END);
    
    disp(TEST_START + 1);
    disp(END);
    
    NN = newrb(INPUT_TRAIN, TARGET_TRAIN, GOAL, SPREAD_CONSTANT);
    OUTPUT = sim(NN, INPUT_TEST);
    plotconfusion(TARGET_TEST, OUTPUT);
    [dummy,CM] = confusion(TARGET_TEST,OUTPUT);
    disp(CM);    
end

