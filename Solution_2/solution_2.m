clear;
lk = 0;
error = 0;
Result_Mean = 0;

for lk = 1:100
    % Initialize the parameters for the simulation
    P = 100;  % Total number of papers
    W = 3;    % Number of winning papers
    J = 8;    % Number of judges
    errort = 0;

    % Generate random scores for papers
    s = ceil(randi([1 100], [1, P]));

    % Create a matrix for real scores
    s_real = [1:100; s];
    s = s_real';
    
    % Generate random result data (not used in this code)
    Result = rand(1000, 1);

    % Generate random ranks for papers
    r = ceil(randi([1 10], [P, 1]));
    
    % Percentage of papers to reject
    p = 0.2;

    % Number of times (not used in this code)
    m = 5;

    % Generate random values (not used in this code)
    h = 0.6 + (0.9 - 0.6) .* rand([J 1]);
    
    iter = 1;

    % First big while loop - Random assignment and rejection
    while P > J * W
        % Generate indices to assign papers to judges
        indices = crossvalind('Kfold', P, J);
        score_j = [];

        for j = 1:J
            temp = 1;
            for i = 1:P
                if indices(i) == j
                    score_j(temp, 2 * j - 1:2 * j) = s(i, :);
                    temp = temp + 1;
                end
            end
        end

        for j = 1:J
            % Sort scores for each judge
            score_j(:, 2 * j - 1:2 * j) = sortrows(score_j(:, 2 * j - 1:2 * j), 2);
        end

        % Remove the lowest p percentile of papers
        score_j(1:ceil(p * P / J), :) = [];
        P = size(score_j, 1) * size(score_j, 2) / 2;
        s = reshape(score_j', 2, P);
        s = s';
        iter = iter + 1;
    end

    iter_2 = 1;

    % Second while loop - Ranking, mean calculation, and rejection
    while P > 2 * W
        score_j_2_temp = [];
        score_j_2 = [];
        s_temp = [];
        s_2 = repmat(s, J, 1);
        s_2 = s_2(1:J * W, :);
        indices = crossvalind('Kfold', J * W, J);

        for j = 1:J
            temp = 1;
            for i = 1:J * W
                if indices(i) == j
                    score_j_2_temp(temp, 2 * j - 1:2 * j) = s_2(i, :);
                    temp = temp + 1;
                end
            end
        end

        for j = 1:J
            score_j_2_temp(:, 2 * j - 1:2 * j) = sortrows(score_j_2_temp(:, 2 * j - 1:2 * j), 2);
            score_j_2_temp(:, 2 * j) = 1:W;
        end

        score_j_2_temp = reshape(score_j_2_temp', 2, J * W);
        score_j_2_temp = score_j_2_temp';
        score_j_2(:, 1) = s(:, 1);

        for index = 1:length(s(:, 1))
            u = find(score_j_2_temp(:, 1) == score_j_2(index, 1));
            e = [];

            if 3 * P < J * W
                for r = 1:length(u)
                    e(r) = abs(sum(score_j_2_temp(u, 1)) - score_j_2_temp(u(r), 1) / (length(u) - 1) - score_j_2_temp(u(r), 1));
                end

                if sum(length(find(e == 0))) == length(e)
                    score_j_2(index, 2) = mean(score_j_2_temp(u, 2));
                else
                    score_j_2(index, 2) = sum(score_j_2_temp(u, 2) ./ e');
                end
            else
                u = find(score_j_2_temp(:, 1) == score_j_2(index, 1));
                score_j_2(index, 2) = mean(score_j_2_temp(u, 2));
            end
        end

        score_j_2 = sortrows(score_j_2, 2);
        score_j_2(1:P * p, :) = [];
        P = length(score_j_2);
        s_temp(:, 1) = score_j_2(:, 1);

        [C, ia, ib] = intersect(s_temp, s);
        s_temp(ia, 2) = s(ib, 2);
        s = s_temp;
        iter_2 = iter_2 + 1;
    end

    % Mapping results and setting result thresholds
    Result(Result <= 0.04) = 16;
    Result(Result <= 0.36) = 17;
    Result(Result <= 0.8) = 18;
    Result(Result <= 0.98) = 19;
    Result(Result <= 0.998) = 20;
    Result(Result <= 1) = 21;

    s = sortrows(s, 2);

    disp(['the index of the best paper is']);
    for i = 1:W
        disp(num2str(s(end - W + i, 1));
    end

    s_real_2 = sortrows(s_real', 2);

    disp(['the index of the best paper is']);
    for i = 1:2 * W
        disp(num2str(s_real_2(end - 2 * W + i, 1));
    end

    Result_Mean = Result_Mean + Result(lk) / 1000;
    Result_Max = max(max(Result));
    Result_Min = min(min(Result));
    lk = lk + 1;

    [max_a, indexa] = max(s_real, [], 2);
    s_real(2, indexa(2)) = 0;
    [max_b, indexb] = max(s_real, [], 2);
    s_real(2, indexb(2)) = 0;
    [max_c, indexc] = max(s_real, [], 2);
    s_real(2, indexc(2)) = 0;

    A = [indexa(2); indexb(2); indexc(2)];
    B = [s(end - 2, 1); s(end - 1, 1); s(end, 1)];

    for ii = 1:W
        [max_A, indexA] = max(A);
        [max_B, indexB] = max(B);

        if (max_A - max_B) == 0
            A(indexA) = 0;
            B(indexB) = 0;
            errort = errort + 1;
        end
    end

    if errort ~= 3
        error = error + 1;
    end
end

correct = lk - error;

% "correct" here stands for how many times this algorithm outputs the
% "true" W best papers out of 2W.
correct
P
