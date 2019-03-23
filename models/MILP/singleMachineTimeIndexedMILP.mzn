% Single machine time-indexed scheduling: MILP Model (MiniZinc implementation)
% Author: Kyle E. C. Booth (kbooth@mie.utoronto.ca)
% Usage: Scheduling Course

% Define problem instance 
n = 4; % number of jobs
p = [2, 2, 3, 4]; % job processing times
H = 20; % upper bound on the scheduling horizon

% Parameters
int: n; 
int: H;
set of int: J = 1..n;
set of int: T = 1..H;
array[J] of int: p;

% Variables
array[J] of var int: C; % job completion time variables
array[J, T] of var 0..1: x; % x[j][t] = 1 if job j starts at time t, 0 otherwise
var int: Z; % objective variable

% Constraints
% Each job starts once
constraint forall(j in J)(
		sum(t in T)(x[j,t]) == 1
	);

% Linking x[j][t] to completion time, C[j]
constraint forall(j in J)(
		sum(t in T)((t + p[j]) * x[j,t]) <= C[j] 
	);

% Resource capacity constraint with t_ \in {t-p[j]+1..t} set
constraint forall(t in T)(
		sum(j in J)(sum(t_ in t-p[j]+1..t where t_ >= 1)(x[j,t_])) <= 1
	);

% Objective bounding
constraint sum(j in J)(C[j]-1) <= Z; % We add 'C[j]-1' b/c MiniZinc completion times will all be offset by +1 (as it starts at 1 instead of 0)

% Objective function
solve minimize Z;

% Solution output
output ["Sum of completion times: ", show(Z)]
