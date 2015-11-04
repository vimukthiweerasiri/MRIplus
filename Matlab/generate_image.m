function RESULT = generate_image(INPUT, N, NET)
  [HEIGHT, WIDTH] = size(INPUT);
  NEW_IMAGE = INPUT;

  for i = 1:N:HEIGHT-N
    for j = 1:N:WIDTH-N
      SUB_INPUT = INPUT(i: i + N - 1, j: j + N - 1);
      NORMALIZED_MAT = normalize(SUB_INPUT);
      RESULT = sim(NET, NORMALIZED_MAT);
      NEW_IMAGE(i: i + N - 1, j: j + N - 1) = (round(RESULT) * 255);
    end
  end
  RESULT = NEW_IMAGE;
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
