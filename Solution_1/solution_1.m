% Clearing the workspace and initializing variables
clear;
lk = 0; % Initializing the variable for tracking simulation runs
error = 0; % Initializing error tracking variable
Result_Mean = 0; % Initializing the variable for tracking the mean of simulation results

% Main loop to run the simulation multiple times
for lk = 1:100
    P = 100; % Total number of papers
    W = 3; % Number of papers to be selected as winners
    J = 8; % Number of judges
    errort = 0; % Error tracking variable

    % Generating random scores (simulated real scores)
    s = ceil(randi([1 100], [1, P]));
    s_real = [1:100; s]; % Pairing scores with paper index
    s = s_real';

    Result = rand(1000, 1); % Generating random results

    % Generating random ranks
    r = ceil(randi([1 10], [P, 1]));

    p = 0.18; % Reject percentage

    % Initial while loop for eliminating papers
    while P > J * W
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

        % Sorting papers within each judge's selection
        for j = 1:J
            score_j(:, 2 * j - 1:2 * j) = sortrows(score_j(:, 2 * j - 1:2 * j), 2);
        end

        % Removing the bottom percentage of papers
        score_j(1:ceil(p * P / J), :) = [];
        P = size(score_j, 1) * size(score_j, 2) / 2;
        s = reshape(score_j', 2, P);
        s = s';
    end

    % Second while loop for further elimination
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
            % Sorting and assigning ranks within each judge's selection
            score_j_2_temp(:, 2 * j - 1:2 * j) = sortrows(score_j_2_temp(:, 2 * j - 1:2 * j), 2);
            score_j_2_temp(:, 2 * j) = 1:W;
        end

        % Reshaping and calculating the mean rank for each paper
        score_j_2_temp = reshape(score_j_2_temp', 2, J * W);
        score_j_2_temp = score_j_2_temp';
        score_j_2(:, 1) = s(:, 1);

        for index = 1:length(s(:, 1))
            u = find(score_j_2_temp(:, 1) == score_j_2(index, 1));
            score_j_2(index, 2) = mean(score_j_2_temp(u, 2));
        end

        % Sorting and removing the bottom percentage of papers
        score_j_2 = sortrows(score_j_2, 2);
        score_j_2(1:P * p, :) = [];
        P = length(score_j_2);
        s_temp(:, 1) = score_j_2(:, 1);

        % Renewing the score list
        [C, ia, ib] = intersect(s_temp, s);
        s_temp(ia, 2) = s(ib, 2);
        s = s_temp;
    end

    % Mapping result values to a certain range
    Result(Result <= 0.042) = 16;
    Result(Result <= 0.398) = 17;
    Result(Result <= 0.82) = 18;
    Result(Result <= 0.991) = 19;
    Result(Result <= 0.998) = 20;
    Result(Result <= 1) = 21;

    % Sorting the papers by score
    s = sortrows(s, 2);

    disp('The index of the best paper is');
    for i = 1:W
        disp(num2str(s(end - W + i, 1)));
    end

    % Sorting the papers by real score
    s_real_2 = sortrows(s_real', 2);
    disp('The index of the best paper is');
    for i = 1:2 * W
        disp(num2str(s_real_2(end - 2 * W + i, 1)));
    end

    Result_Mean = Result_Mean + Result(lk) / 1000;
    Result_Max = max(max(Result));
    Result_Min = min(min(Result));
    lk = lk + 1; % Incrementing the tracking variable

    % Find the top three papers from the real scores
    [max_a, indexa] = max(s_real, [], 2);
    s_real(2, indexa(2)) = 0;
    [max_b, indexb] = max(s_real, [], 2);
    s_real(2, indexb(2)) = 0;
    [max_c, indexc] = max(s_real, [], 2);
    s_real(2, indexc(2)) = 0;

    A = [indexa(2); indexb(2); indexc(2)];
    B = [s(end - 2, 1); s(end - 1, 1); s(end, 1)];

    % Check if there is an error in the top three papers
    for ii = 1:W
        [max_A, indexA] = max(A);
        [max_B, indexB] = max(B);

        if (max_A - max_B) == 0
            A(indexA) = 0;
            B(indexB) = 0;
            errort = errort + 1;
        end
    end

    % Check if there were three errors in the top papers
    if errort ~= 3
        error = error + 1;
    end
end

correct = lk - error; % Calculating the number of correct runs
correct % Displaying the number of correct runs
P % Displaying the final value of P
