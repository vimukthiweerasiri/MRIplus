function [IN, OUT] = get_data(i)
    INPUT = read_mha(strcat('Images/SET1/IN/',num2str(i), '.mha'));
    OUTPUT = read_mha(strcat('Images/SET1/OUT/',num2str(i), '.mha'));
    
    
    MIDDLE_I = INPUT(:,:,round(end/2));
    MIDDLE_I = mat2gray(MIDDLE_I);
    imwrite(MIDDLE_I, strcat('Images/SET1/MIDDLE_PLANES/IN/','i',num2str(i), '.png'));
    
    MIDDLE_O = OUTPUT(:,:,round(end/2));
    MIDDLE_O = mat2gray(MIDDLE_O);
    imwrite(MIDDLE_O, strcat('Images/SET1/MIDDLE_PLANES/OUT/','o',num2str(i), '.png'));
    disp(size(MIDDLE_I));
    IN = MIDDLE_I;
    OUT = MIDDLE_O;
end

