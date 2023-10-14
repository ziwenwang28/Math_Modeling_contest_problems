# README

## Initialization and Setup

At the start of the simulation, several critical variables are initialized:

- **lk**: Initialized to zero, this variable is used to track simulation results.
- **error**: Also initialized to zero, it serves as another tracker for the simulation.
- **Result_Mean**: This variable is set to zero and will be used to track the mean of simulation results.

## Main Loop (for Simulation)

The primary simulation process is conducted through a for loop that runs 100 times. Each iteration simulates the judging process, enabling us to evaluate the performance of the judging algorithm.

## Setting Initial Parameters

Within each iteration of the loop, various parameters are initialized to configure the simulation run:

- **P**: This represents the total number of papers (default value: 100).
- **W**: Denotes the number of papers to be selected as winners (default value: 3).
- **J**: Indicates the number of judges available for evaluation (default value: 8).
- **s**: A vector containing randomly generated scores assigned to each paper.
- **s_real**: A matrix used to store actual scores for each paper.
- **r**: A vector for assigning random ranks to each paper.
- **p**: Specifies the percentage of papers to be rejected during the selection process (default value: 20%).
- **m**: A variable set to 5, though not utilized in this code.
- **h**: A vector containing random values, also not used in this code.

## First While Loop: Random Assignment and Rejection

The first while loop simulates the initial paper assignment and rejection process, with the aim of reducing the number of papers to a manageable level for evaluation. Within this loop:

- Judges are randomly assigned to evaluate papers, ensuring that each paper is assessed by a specific judge.
- The scores for each paper are sorted based on the assigned judge's evaluation.
- A percentage (p) of the lowest-scoring papers is rejected.
- The value of P is updated to reflect the remaining papers.
- The scores are reshaped in preparation for the next iteration.

## Second While Loop: Ranking and Mean Calculation

The second while loop focuses on simulating the ranking and mean calculation process, with the objective of further reducing the number of papers to a smaller set of potential winners. Within this loop:

- Judges are once again assigned to evaluate papers.
- Papers are ranked based on numerical scores assigned by judges.
- A modified mean is calculated for each paper to account for ties in scores.
- A percentage (p) of the lowest-ranking papers is rejected.
- The value of P is updated to reflect the remaining papers.
- The scores are reshaped for the next iteration.

## Result Mapping and Thresholds

Following both while loops, the results are mapped to specific thresholds. For instance, papers with scores less than or equal to 0.04 are mapped to 16. The code then proceeds to sort the papers by their scores.

## Displaying Results

This section outlines how the algorithm displays the indexes of the best papers (winners) based on the ranking and scoring. It also provides indexes based on the original real scores.

## Calculating and Storing Statistics

The code calculates the mean, maximum, and minimum results from the simulation and stores these values for further analysis.

## Check for Correct Winners

To ensure the accuracy of the algorithm, the code checks if it correctly identifies the best papers. This verification is accomplished by comparing the algorithm's selections with the true top papers based on actual scores.

## Display the Number of Correct Selections and Final P

The code displays two important pieces of information:

- The number of times the algorithm correctly identified the best papers.
- The final value of P, which represents the number of papers left in the last round.

## End of Loop and Iteration

The primary simulation loop continues for a total of 100 iterations, with each iteration simulating a complete judging process. This section concludes the README by summarizing the overall simulation process.

## Sample Output

After the simulation runs, the code provides output to help analyze the results. Here's a sample of what you might expect:

### Index of the Best Paper(s)

The code displays the index(es) of the best paper(s) based on the ranking and scoring. In this sample output, the best paper(s) are identified by their respective indices:

- 24
- 32
- 93

### Index of the Best Paper(s) Based on Actual Scores

Additionally, the code displays the index(es) of the best paper(s) based on the original real scores:

- 36
- 49
- 54
- 24
- 32
- 93

### Number of Correct Selections

The code provides the number of times the algorithm correctly identified the best paper(s). In this sample output, it is:

- 87

### Final Value of P

The final value of P, which represents the number of papers left in the last round, is also displayed in the output:

- 6

This sample output gives an idea of what to expect when running the code and provides important results for analysis.
