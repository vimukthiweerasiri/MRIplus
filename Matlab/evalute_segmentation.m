function ERROR = evalute_segmentation( INPUT, OUTPUT )
%EVALUTE_SEGMENTATION Summary of this function goes here
%   Detailed explanation goes here
  INPUT1 = mat2gray(INPUT);
  OUTPUT1 = mat2gray(OUTPUT);

  INPUT2 = im2bw(INPUT1, 0);
  OUTPUT2 = im2bw(OUTPUT1, 0);

  INPUT3 = imfill(INPUT2, 'holes');
  OUTPUT3 = imfill(OUTPUT2, 'holes');


  ANDIMAGE = and(INPUT3, OUTPUT3);


  [INPUT_LABELED, NUM_INPUT_LABELS] = bwlabel(INPUT3);
  OUTPUT_LABELED = bwlabel(OUTPUT3);

  [RESULT_LABELED, NUM_LABELS] = bwlabel(ANDIMAGE);


  for i = 1:NUM_LABELS
    [x, y] = find(RESULT_LABELED == i, 1);
    INPUT_REFERING_VALUE = INPUT_LABELED(x, y);
    OUTPUT_REFERING_VALUE = OUTPUT_LABELED(x, y);
    INPUT_AREA = sum(INPUT_LABELED(:) == INPUT_REFERING_VALUE);
    OUTPUT_AREA = sum(OUTPUT_LABELED(:) == OUTPUT_REFERING_VALUE);
    disp('cluster');
    disp(i);
    disp(INPUT_AREA);
    disp(OUTPUT_AREA);
    disp('difference');
    disp(OUTPUT_AREA - INPUT_AREA);
    INPUT_LABELED(INPUT_LABELED == INPUT_REFERING_VALUE) = 0;
  end

  for j = 1:NUM_INPUT_LABELS
    WRONG_AREA = sum(INPUT_LABELED(:) == j);
    if WRONG_AREA ~= 0
      disp('wrong clusters');
      disp(j);
      disp('area');
      disp(WRONG_AREA);
    end
  end
  
  ERROR = 0;

end
