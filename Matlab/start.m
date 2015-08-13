I = read_mha('Images/Input/brain1.mha');
% getting the middle plane
MIDDLE_PLANE = I(:,:,round(end/2));
MP2GRAY = mat2gray(MIDDLE_PLANE);
imshow(MP2GRAY);