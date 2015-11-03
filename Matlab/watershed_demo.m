MHA_3D = read_mha('Images/Input/brain1.mha');
% getting the middle plane
MHA_PLANE = MHA_3D(:,:,round(end/2));
I = mat2gray(MHA_PLANE);
%figure
%imshow(I);

%edge detection
hy = fspecial('sobel');
hx = hy';
Iy = imfilter(double(I), hy, 'replicate');
Ix = imfilter(double(I), hx, 'replicate');
gradmag = sqrt(Ix.^2 + Iy.^2);
%figure
%imshow(gradmag,[])

%With gradient magnitude
%L = watershed(gradmag);
%Lrgb = label2rgb(L);
%imshow(Lrgb)

%Masking the background
se = strel('disk', 20);
Io = imopen(I, se);
%figure
%imshow(Io);
Ie = imerode(I, se);
Iobr = imreconstruct(Ie, I);
%figure
%imshow(Iobr)
Ioc = imclose(Io, se);
%figure
%imshow(Ioc);

%Image reconstruction
Iobrd = imdilate(Iobr, se);
Iobrcbr = imreconstruct(imcomplement(Iobrd), imcomplement(Iobr));
Iobrcbr = imcomplement(Iobrcbr);
figure
imshow(Iobrcbr),title('Iobrcbr');

%reconstruction of foreground markers
fgm = imregionalmax(Iobrcbr);
%figure
%imshow(fgm);

%Impose markers on original Image
I2 = I;
I2(fgm) = 255;
%figure
%imshow(I2);

%Marker smoothening
se2 = strel(ones(5,5));
fgm2 = imclose(fgm, se2);
fgm3 = imerode(fgm2, se2);
fgm4 = bwareaopen(fgm3, 20);
I3 = I;
I3(fgm4) = 255;
figure
imshow(I3);
%Perefect

%watershed
bw = im2bw(Iobrcbr, graythresh(Iobrcbr));
%figure
%imshow(bw)
D = bwdist(bw);
DL = watershed(D);
bgm = DL == 0;
%figure
%imshow(bgm);

%All combined
gradmag2 = imimposemin(gradmag, bgm | fgm4);
L = watershed(I);
I4 = I;
I4(imdilate(L == 0, ones(3, 3)) | bgm | fgm4) = 255;
figure
imshow(I4)
title('Markers and object boundaries superimposed on original image (I4)')
%Lrgb = label2rgb(L, 'jet', 'w', 'shuffle');
Mgs = mat2gray(255* L./max(L(:)));
figure
imshow(Mgs)
title('Colored watershed label matrix (Lrgb)')
figure
imshow(I)
hold on
himage = imshow(Mgs);
himage.AlphaData = 0.3;
title('Lrgb superimposed transparently on original image')


