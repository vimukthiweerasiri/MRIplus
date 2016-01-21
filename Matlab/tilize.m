function [T_INPUT, T_OUTPUT] = tilize(INPUT, OUTPUT, N, WITH_EDGES)
    if (nargin < 4)
        WITH_EDGES = false;
    end
    INPUT = double(INPUT);
    OUTPUT = double(OUTPUT);
    [HEIGHT, WIDTH] = size(INPUT);
    TRAINING_IDX = 1;
    TRAINING_OUTPUT = [];
    TRAINING_INPUT = [];

    for i = 1:N:HEIGHT-N
        for j = 1:N:WIDTH-N
            SUB_INPUT = INPUT(i: i + N - 1, j: j + N - 1);
            SUB_OUTPUT = OUTPUT(i: i + N - 1, j: j + N - 1);
            IN_SUM = sum(SUB_INPUT(:) == 0);
            if IN_SUM == N*N
                continue;
            end
            
            % Omits the edges of the brain
            % Can confuse NN with tumor-brain edge
            if WITH_EDGES
                IS_EDGE = IsBrainEdge(INPUT, N, i, j, HEIGHT, WIDTH);
                if IS_EDGE
                    continue
                end
            end
            OUT_SUM = sum(SUB_OUTPUT(:) == 0);
            if OUT_SUM == 0
                %         disp('YES');
                TRAINING_OUTPUT(TRAINING_IDX) = 1;

                NORM_RESULT = normalize(SUB_INPUT);
                %         disp(NORM_RESULT);
                TRAINING_INPUT(:,TRAINING_IDX) = NORM_RESULT(:);

                TRAINING_IDX = TRAINING_IDX + 1;
            elseif OUT_SUM == N*N
                %         disp('NO');
                TRAINING_OUTPUT(TRAINING_IDX) = 0;

                NORM_RESULT = normalize(SUB_INPUT);
                %         disp(NORM_RESULT);
                TRAINING_INPUT(:,TRAINING_IDX) = NORM_RESULT(:);

                TRAINING_IDX = TRAINING_IDX + 1;
            elseif WITH_EDGES
                %         disp('NO');
                TRAINING_OUTPUT(TRAINING_IDX) = -1;

                NORM_RESULT = normalize(SUB_INPUT);
                %         disp(NORM_RESULT);
                TRAINING_INPUT(:,TRAINING_IDX) = NORM_RESULT(:);

                TRAINING_IDX = TRAINING_IDX + 1;
            end
        end
    end
    T_INPUT = TRAINING_INPUT;
    T_OUTPUT = TRAINING_OUTPUT;
end

function IS_EDGE = IsBrainEdge(INPUT, N, i_c, j_c, H, W)
% This functin checks if a given block contains edge of the brain
% returns true for the edges, false otherwise
    if (i_c - N) < 1
        i_start = i_c;
    else
        i_start = i_c - N;
    end
    
    if (i_c + N) > (H - N)
        i_end = i_c;
    else
        i_end = i_c + N;
    end
    
    if (j_c - N) < 1
        j_start = j_c;
    else
        j_start = j_c - N;
    end
    
    if (j_c + N) > (W - N)
        j_end = j_c;
    else 
        j_end = j_c + N;
    end
    
    TEMP = false;
    for i = i_start:N:i_end
        for j = j_start:N:j_end 
            SUB_INPUT = INPUT(i: i + N - 1, j: j + N - 1);
            SUB_SUM = sum(SUB_INPUT(:) == 0);
            if SUB_SUM == N*N
                TEMP = true;
                break;
            end
        end
        if TEMP
            break;
        end
    end
   IS_EDGE = TEMP;
end


function MAT = normalize(INPUT)
    VEC_MAT = INPUT(:);
    MEAN = mean(VEC_MAT);
    VAR = var(double(VEC_MAT), 1);
    INPUT = INPUT - MEAN;
    if VAR ~= 0
        INPUT = INPUT / VAR;
    end
    MAT = INPUT;
end