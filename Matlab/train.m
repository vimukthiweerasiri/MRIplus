function [NN, TIME] = train()
    IN = imread('Images/SET1/MIDDLE_PLANES/IN/i1.png');
    OUT = imread('Images/SET1/MIDDLE_PLANES/OUT/o1.png');
    [T_IN T_OUT] = tilize(IN, OUT, 8);
	for i = 2:3
        IN_I = imread(strcat('Images/SET1/MIDDLE_PLANES/IN/','i',num2str(i), '.png'));
        OUT_I = imread(strcat('Images/SET1/MIDDLE_PLANES/OUT/','o',num2str(i), '.png'));
		[X Y] = tilize(IN_I, OUT_I, 8);
        T_IN = [T_IN X];
        T_OUT = [T_OUT Y];
    end
    START = cputime;
 	NN = newrb(T_IN, T_OUT);
    TIME = cputime - START;
    disp(TIME);
    
end