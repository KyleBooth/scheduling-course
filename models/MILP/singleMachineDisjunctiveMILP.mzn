% Single machine disjunctive scheduling: MILP Model (MiniZinc implementation)
% Author: Kyle E. C. Booth (kbooth@mie.utoronto.ca)
% Usage: Scheduling Course

% Define problem instance 
% Instance from Term Test #1, Q1 (True/False)
n = 10; % number of jobs
p = [3, 3, 4, 5, 7, 2, 3, 3, 4, 7]; % job processing times
r = [1, 5, 12, 3, 11, 0, 20, 1, 6, 15]; % job release times
M = 10000;
H = 10000;

% Parameters
int: n; 
int: M;
int: H;
set of int: J = 1..n;
set of int: JJ = 1..n*n;
array[J] of int: p;
array[J] of int: r;

% Variables
array[J] of var int: S; % job start time variables
array[J] of var int: C; % job completion time variables
array[JJ] of var 0..1: x; % job ordering variables
var int: Z; % objective variable

% Constraints
constraint forall(j in J)(C[j] == S[j] + p[j]);

constraint forall(i in J)(forall(j in J where i != j)(S[i] >= S[j] + p[j] - M * x[(i - 1) * n + j]));

constraint forall(i in J)(forall(j in J where i != j)(S[j] >= S[i] + p[i] - M * (1 - x[(i - 1) * n + j])));

constraint forall(j in J)(S[j] >= r[j]);

constraint forall(j in J)(S[j] <= H - p[j]);

% Objective bounding
constraint sum(j in J)(C[j]) == Z;

% Objective function
solve minimize Z;

% Solution output
output ["Sum of completion times: ", show(Z), "; \n Job start times: ", show(S), "; \n Ordering vars: ", show(x)]
 






