function generate_allData_once( TILE_SIZE, WITH_EDGES, EDGE_LABEL)
% This function generate the data for ANN
% TILE_SIZE: Breaks images into n x n tiles. Default is 8
    if nargin < 1
        TILE_SIZE = 8;
    end
    
    if nargin < 2
        WITH_EDGES = false;
    end
    
    if nargin < 3
        EDGE_LABEL = -1;
    end    
        

    INPUT32 = imread('../Images/SET1/MIDDLE_PLANES/IN/i38.png');
    TARGET32 = imread('../Images/SET1/MIDDLE_PLANES/OUT/o38.png');
    [INPUT TARGET] = tilize(INPUT32, TARGET32, TILE_SIZE, WITH_EDGES);
    
        
	for i = 33:80
        IN_I = imread(strcat('../Images/SET1/MIDDLE_PLANES/IN/','i',num2str(i), '.png'));
        TARGET_I = imread(strcat('../Images/SET1/MIDDLE_PLANES/OUT/','o',num2str(i), '.png'));
		[X, Y] = tilize(IN_I, TARGET_I, 8);
        INPUT = [INPUT, X];
        TARGET = [TARGET, Y];
    end
    
    INPUT_ONE = [];
    TARGET_ONE = [];
    INPUT_ZERO = [];
    TARGET_ZERO = [];
    
    % MONE - MINUS ONE
    INPUT_MONE = [];     
    TARGET_MONE = [];
    
    for index = 1:length(TARGET)
        if TARGET(index) == 1
            INPUT_ONE = [INPUT_ONE INPUT(:, index)];
            TARGET_ONE = [TARGET_ONE TARGET(index)];
        elseif TARGET(index) == 0
            INPUT_ZERO = [INPUT_ZERO INPUT(:, index)];
            TARGET_ZERO = [TARGET_ZERO TARGET(index)];
        elseif WITH_EDGES
            INPUT_MONE = [INPUT_MONE INPUT(:, index)];
            TARGET_MONE = [TARGET_MONE EDGE_LABEL];
        end
    end
    
    % Debugging       
    disp(size(INPUT_ONE))
    disp(size(INPUT_ZERO))
    disp(size(INPUT_MONE))
    
    rIdx = randperm(length(TARGET_ZERO));
    rZERO_INPUT = INPUT_ZERO(:, rIdx);
    rZERO_TARGET = TARGET_ZERO(rIdx);
    
    len = max(length(TARGET_ONE),length(TARGET_MONE));
    
    rZERO_INPUT_FIRST = rZERO_INPUT(:, 1:len);
    rZERO_TARGET_FIRST = rZERO_TARGET(1:len);
    
    fINPUT = [INPUT_ONE rZERO_INPUT_FIRST];
    fTARGET = [TARGET_ONE rZERO_TARGET_FIRST];
    
    if WITH_EDGES
        fINPUT = [fINPUT INPUT_MONE];
        fTARGET = [fTARGET TARGET_MONE];
    
    rFIdx = randperm(length(fTARGET));
    equalizedINPUT = fINPUT(:, rFIdx);
    equalizedTARGET = fTARGET(rFIdx);
    
%    save('equalizedDATA', 'equalizedINPUT', 'equalizedTARGET');
    save('Edge_equalizedDATA8x8', 'equalizedINPUT', 'equalizedTARGET');
    
%     nrINPUT = INPUT;
%     nrTARGET = TARGET;
    %save('notRandomizedDATA', 'nrINPUT', 'nrTARGET');
    
    % randomizing
%     idx = randperm(length(TARGET));
%     INPUT = INPUT(:, idx);
%     TARGET = TARGET(idx);
    %save('DATA', 'INPUT', 'TARGET');
end

