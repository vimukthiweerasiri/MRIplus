function sweetspot()
    fid = fopen('results.txt', 'a+');
    start = 0.5;
    span = 1000;
    testSpan = 100;
    error = 5e-5;
    spread = 150;
    
    % change these when need and append to the arguments
    mn = 0;
    df = 0;
    
    
    for TSPAN = 1 : testSpan : span - testSpan
        P = evalRBFNN(start, span, TSPAN, testSpan - 1, error, spread);
        fprintf(fid, 'start: %d, span: %d, testStart: %d, testEnd: %d, error: %f, spread: %f\t||\tTP: %d, TN: %d, FP: %d, FN: %d\n', start, span, TSPAN, TSPAN + testSpan - 1, error, spread, P(4), P(1), P(2), P(3));
    end
    
    fclose(fid);

end

