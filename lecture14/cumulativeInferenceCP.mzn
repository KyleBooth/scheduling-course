% CP Cumulative Inference: CP Model (MiniZinc implementation)
% Author: Kyle E. C. Booth (kbooth@mie.utoronto.ca)
% Usage: Scheduling Course

% Include the required global constraint
include "cumulative.mzn";

% Define problem instance (temporal prop + CBA example, Lecture 14)
n = 3; % number of jobs
p = [6, 5, 4]; % job processing times
r = [1, 1, 1]; % resource consumptions
B = 1; % unary capacity resource

% Parameters
int: n; 
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

constraint S[1] >= 0; constraint C[1] <= 17; % Time windows of jobs
constraint S[2] >= 1; constraint C[2] <= 11;
constraint S[3] >= 1; constraint C[3] <= 12;

constraint S[2] >= C[3]; % A3 -> A2

%constraint S[3] == 2;

constraint cumulative(S, p, r, B); % Cumulative global constraint

% Objective bounding
constraint sum(j in J)(C[j]) == Z;

% Objective function (satisfaction)
solve satisfy;

% Solution output
output ["Job start times: ", show(S)]
