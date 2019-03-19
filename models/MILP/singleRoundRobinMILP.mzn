% Scotties Curling Tournament (Single Round Robin): MILP Model (MiniZinc implementation)
% Author: Kyle E. C. Booth (kbooth@mie.utoronto.ca)
% Usage: Scheduling Course

% Define problem instance 
n = 12; % number of teams
r = 11; % number of rounds in a single round robin (n-1)

% Parameters
int: n;
int: r; 
set of int: T = 1..r; % set of rounds 
set of int: I = 1..n; % set of teams
set of int: IIT = 1..n*n*r; 
array[IIT] of var 0..1: x; % 1 if team i plays team j in round t

% Constraints
% Each team plays a single game in each round
constraint forall(i in I)(
		forall(t in T)(
				sum(j in I where j != i)(x[(t-1)*n*n + (i-1)*n + j]) == 1
			)
		);

% Each pair of teams (i != j) plays a game
constraint forall(i in I)(
		forall(j in I where  j != i)(
				sum(t in T)(x[(t-1)*n*n + (i-1)*n + j]) == 1
			)
		);	

% Match definition: if i plays j in t, then j plays i in t
constraint forall(i in I)(
		forall (j in I where j != i)(
			forall (t in T)(
				x[(t-1)*n*n + (i-1)*n + j] == x[(t-1)*n*n + (j-1)*n + i]
				)
			)
		);

% Satisfaction problem
solve satisfy;

% Solution output
output ["Variable output: ", show(x)]




