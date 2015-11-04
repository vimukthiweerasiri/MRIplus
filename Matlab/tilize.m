function [T_INPUT, T_OUTPUT] = tilize(INPUT, OUTPUT, N)
  [HEIGHT, WIDTH] = size(INPUT);
  TRAINING_IDX = 1;
  TRAINING_OUTPUT = [];
  TRAINING_INPUT = [];

  for i = 1:N:HEIGHT-N
    for j = 1:N:WIDTH-N
      SUB_INPUT = INPUT(i: i + N - 1, j: j + N - 1);
      SUB_OUTPUT = OUTPUT(i: i + N - 1, j: j + N - 1);
      OUT_SUM = sum(SUB_OUTPUT(:) == 0);
      if OUT_SUM == 0
        disp('YES');
        TRAINING_OUTPUT(TRAINING_IDX) = 1;

        NORM_RESULT = normalize(SUB_INPUT);
        disp(NORM_RESULT);
        TRAINING_INPUT(:,TRAINING_IDX) = NORM_RESULT(:);

        TRAINING_IDX = TRAINING_IDX + 1;
      end
      if OUT_SUM == N*N
        disp('NO');
        TRAINING_OUTPUT(TRAINING_IDX) = 0;

        NORM_RESULT = normalize(SUB_INPUT);
        disp(NORM_RESULT);
        TRAINING_INPUT(:,TRAINING_IDX) = NORM_RESULT(:);

        TRAINING_IDX = TRAINING_IDX + 1;
      end
    end
  end
  T_INPUT = TRAINING_INPUT;
  T_OUTPUT = TRAINING_OUTPUT;
end

function MAT = normalize(INPUT)
  VEC_MAT = INPUT(:);
  MEAN = mean(VEC_MAT);
  VAR = var(VEC_MAT);
  INPUT = INPUT - MEAN;
  if VAR ~= 0
    INPUT = INPUT / VAR;
  end
  MAT = INPUT;
end