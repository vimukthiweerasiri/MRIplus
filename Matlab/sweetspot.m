function sweetspot()
    fid = fopen('results.txt', 'a+');
    start = 0.5;
    span = 2000;
    testPercentage = 0.5;
    error = 5e-5;
    spread = 1;
    
    % change these when need and append to the arguments
    mn = 0;
    df = 0;
    
    for SPD = 1: 50: 500
        spread = SPD;
        P = evalRBFNN(start, span, testPercentage, error, spread);
        fprintf(fid, 'start: %d, span: %d, testPercentage: %f, error: %f, spread: %f\t||\tTP: %d, TN: %d, FP: %d, FN: %d\n', start, span, testPercentage, error, spread, P(4), P(1), P(2), P(3));
    end
    fclose(fid);

end

