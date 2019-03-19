% Scotties Curling Tournament (Single Round Robin): CP Model (MiniZinc implementation)
% Author: Kyle E. C. Booth (kbooth@mie.utoronto.ca)
% Usage: Scheduling Course

% Include the required global constraint
include "all_different.mzn";

% Define problem instance 
n = 12; % number of teams
r = 11; % number of rounds in a single round robin (n-1)

% Parameters
int: n;
int: r; 
set of int: T = 1..r; % set of rounds 
set of int: I = 1..n; % set of teams
set of int: TI = 1..r*n;
array[TI] of var 0..n: y; % y_{it} = {1,...,12} is the team that team i plays in round t

% Constraints
% Team cannot play itself
constraint forall(i in I)(
		forall(t in T)(
				y[(t-1)*n + i] != i
			)
		);

% Each team must play every other team (AllDifferent opponent IDs)
constraint forall(i in I)(
			all_different([y[i], y[n+i], y[2*n+i], y[3*n+i], y[4*n+i], y[5*n+i], y[6*n+i], y[7*n+i], y[8*n+i], y[9*n+i], y[10*n+i]])
		);

% Inverse relationship: The team that team i plays, plays team i (tricky to understand, but very effective/concise!)
constraint forall(t in T)(
		forall(i in I)(
			y[(t-1)*n + y[(t-1)*n +i]] == i
			)
		);

solve satisfy;

% Solution output
output ["Variable output: ", show(y)]




