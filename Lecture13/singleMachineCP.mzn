% Single machine disjunctive scheduling: CP Model (MiniZinc implementation)
% Author: Kyle E. C. Booth (kbooth@mie.utoronto.ca)
% Usage: Scheduling Course

% Include the required global constraint
include "cumulative.mzn";

% Define problem instance 
% Instance from Term Test #1, Q1 (True/False)
n = 4; % number of jobs
p = [2, 2, 3, 4]; % job processing times
r = [1, 1, 1, 1]; % resource consumptions: each job consumes one unit of resource (vertical portion of rectangle)
B = 1; % unary capacity resource
H = 10000;

% Parameters
int: n; 
int: H;
int: B;
set of int: J = 1..n;
array[J] of int: p;
array[J] of int: r;

% Variables
array[J] of var int: S; % job start time variables
array[J] of var int: C; % job completion time variables
var int: Z; % objective variable

% Constraints
constraint forall(j in J)(C[j] == S[j] + p[j]);

constraint cumulative(S, p, r, B); % Cumulative global constraint! Much simpler than disjunctive/time-indexed models.

constraint forall(j in J)(S[j] >= 0);

constraint forall(j in J)(S[j] <= H - p[j]);

% Objective bounding
constraint sum(j in J)(C[j]) == Z;

% Objective function
solve minimize Z;

% Solution output
output ["Sum of completion times: ", show(Z), "; \n Job start times: ", show(S)]
