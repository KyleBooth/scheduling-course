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
set of int: I = 1..n; % set of teams
set of int: T = 1..r; % set of rounds 
array[I,T] of var 1..n: y; % y_{it} = {1,...,12} is the team that team i plays in round t

% Constraints
% Team cannot play itself
constraint forall(i in I)(
		forall(t in T)(
				y[i,t] != i
			)
		);

% Each team must play every other team (AllDifferent opponent IDs)
constraint forall(i in I)(
			all_different([y[i,1], y[i,2], y[i,3], y[i,4], y[i,5], y[i,6], y[i,7], y[i,8], y[i,9], y[i,10], y[i,11]])
		);

% Inverse relationship: The team that team i plays, plays team i (tricky to understand, but very effective/concise!)
constraint forall(t in T)(
		forall(i in I)(
			y[y[i,t],t] == i
			)
		);

solve satisfy;

% Solution output
output ["Variable output: ", show(y)]




