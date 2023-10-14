# README

### Initialization and Variable Setup

- The code begins by clearing the workspace and initializing variables.
- `lk`: A variable for tracking the simulation runs.
- `error`: A variable for tracking errors in identifying the top papers.
- `Result_Mean`: A variable for calculating the mean of simulation results.

### Main Loop (for Simulation)

- The primary loop runs for 100 iterations, simulating the judging process multiple times to evaluate the effectiveness of the algorithm. The loop iterates through the simulation runs.

### Setting Initial Parameters

- Inside the loop, various parameters are initialized for each simulation run, including:
  - `P`: The total number of papers in the competition.
  - `W`: The number of papers to be selected as winners.
  - `J`: The number of judges available for evaluation.
  - `s`: A vector containing randomly generated scores assigned to each paper.
  - `s_real`: A matrix that stores the actual scores for each paper.
  - `r`: A vector of randomly assigned ranks to each paper.
  - `p`: The percentage of papers to be rejected during the selection process.
  - `Result`: A vector for storing random results.

### Initial While Loop: Random Assignment and Rejection

- The first while loop simulates the initial paper assignment and rejection process. The goal is to reduce the number of papers to a threshold where each judge can effectively evaluate them.
- The loop performs the following steps:
  - Judges are randomly assigned to evaluate papers.
  - The scores for each paper are sorted based on the assigned judge's evaluation.
  - A percentage of the lowest-scoring papers are rejected.
  - The value of `P` is updated to reflect the remaining papers.
  - The scores are reshaped for the next iteration.

### Second While Loop: Ranking and Mean Calculation

- The second while loop simulates the ranking and mean calculation process to further reduce the number of papers to a smaller set of potential winners.
- In this loop:
  - Judges are again assigned to evaluate papers.
  - Papers are ranked based on numerical scores given by judges.
  - A modified mean is calculated for each paper to account for ties in scores.
  - A percentage of the lowest-ranking papers are rejected.
  - The value of `P` is updated.
  - The scores are reshaped for the next iteration.

### Result Mapping and Thresholds

- After both while loops, the results are mapped to specific thresholds based on the random results.
- The code sorts the papers by scores.

### Displaying Results

- The code displays the indexes of the best papers (winners) based on the ranking and scoring.
- It also displays indexes based on the original real scores.

### Calculating and Storing Statistics

- The code calculates the mean, maximum, and minimum results from the simulation and stores these values.

### Check for Correct Winners

- The code checks if the algorithm correctly identifies the best papers by comparing the algorithm's selections with the true top papers based on actual scores.

### Display the Number of Correct Selections and Final P

- The code displays the number of times the algorithm correctly identified the best papers.
- It also displays the final value of `P`, which is the number of papers left in the last round.

### End of Loop and Iteration

The main loop continues for a total of 100 iterations, with each iteration simulating a complete judging process.

The code repeats this simulation process 100 times, making it possible to evaluate the algorithm's performance in selecting the best papers in a competition.

## Sample Output

After the simulation runs, the code provides output to help analyze the results. Here's a sample of what you might expect:

### The index of the best paper is

The code displays the index(es) of the best paper(s) based on the ranking and scoring. In this sample output, the best paper(s) are identified by their respective indices:

- 33
- 53
- 25

### The index of the best paper is

Additionally, the code displays the index(es) of the best paper(s) based on the original real scores:

- 2
- 31
- 42
- 33
- 53
- 25

### Number of Correct Selections

The code provides the number of times the algorithm correctly identified the best paper(s). In this sample output, it is:

- 76

### Final Value of P

The final value of P, which represents the number of papers left in the last round, is also displayed in the output:

- 6

This sample output gives an idea of what to expect when running the code and provides important results for analysis.
