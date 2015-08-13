I = read_mha('Images/Input/brain1.mha');
% getting the middle plane
MIDDLE_PLANE = I(:,:,round(end/2));
MP2GRAY_SCALE = mat2gray(MIDDLE_PLANE);
imshow(MP2GRAY_SCALE);