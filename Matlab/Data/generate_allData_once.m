function generate_allData_once( TILE_SIZE, WITH_EDGES, EDGE_LABEL, NO_MID, MID_LABEL)
% This function generate the data for ANN
% TILE_SIZE: Breaks images into n x n tiles. Default is 8
% WITH_EDGES: true for use edges in data
% EDGE_LABEL: digit to set class for edge label. Default is -1
% NO_MID: true to remove tumor mid parts from the dataset
% MID_LABEL: digit to set class for edge label. Default is 1
    if nargin < 1
        TILE_SIZE = 8;
    end
    
    if nargin < 2
        WITH_EDGES = false;
    end
    
    if nargin < 3
        EDGE_LABEL = -1;
    end    
        
    if nargin < 4
        NO_MID = false;
    end
   
    if nargin < 5
        MID_LABEL = 1;
    end
   
    INPUT = [];
    TARGET = [];
	for i = 33:80
        IN_I = imread(strcat('../Images/SET1/MIDDLE_PLANES/IN/','i',num2str(i), '.png'));
        TARGET_I = imread(strcat('../Images/SET1/MIDDLE_PLANES/OUT/','o',num2str(i), '.png'));
		[X, Y] = tilize(IN_I, TARGET_I, TILE_SIZE, WITH_EDGES);
        INPUT = [INPUT, X];
        TARGET = [TARGET, Y];
        dicomwrite(IN_I, strcat('I', num2str(i), '.dcm'));
        dicomwrite(TARGET_I, strcat('O', num2str(i), '.dcm'));
    end
    
    
end

