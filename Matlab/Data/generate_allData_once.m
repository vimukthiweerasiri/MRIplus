function generate_allData_once( TILE_SIZE )
% This function generate the data for ANN
% TILE_SIZE: Breaks images into n x n tiles. Default is 8
    if nargin < 1
        TILE_SIZE = 8;
    end

    INPUT32 = imread('../Images/SET1/MIDDLE_PLANES/IN/i32.png');
    TARGET32 = imread('../Images/SET1/MIDDLE_PLANES/OUT/o32.png');
    [INPUT TARGET] = tilize(INPUT32, TARGET32, TILE_SIZE);
    
        
	for i = 33:80
        IN_I = imread(strcat('../Images/SET1/MIDDLE_PLANES/IN/','i',num2str(i), '.png'));
        TARGET_I = imread(strcat('../Images/SET1/MIDDLE_PLANES/OUT/','o',num2str(i), '.png'));
		[X, Y] = tilize(IN_I, TARGET_I, 8);
        INPUT = [INPUT, X];
        TARGET = [TARGET, Y];
    end
    nrINPUT = INPUT;
    nrTARGET = TARGET;
    save('notRandomizedDATA', 'nrINPUT', 'nrTARGET');
    
    % randomizing
    idx = randperm(length(TARGET));
    INPUT = INPUT(:, idx);
    TARGET = TARGET(idx);
    save('DATA', 'INPUT', 'TARGET');
end

