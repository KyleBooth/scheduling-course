% Bin Packing: IP Model (MiniZinc implementation)
% Author: Kyle E. C. Booth (kbooth@mie.utoronto.ca)
% Usage: Scheduling Course

% Define problem instance 
% Instance from graphic on Slide 16 (Lecture 11): Textbook example 9.4.3
n = 18; % number of items (e.g., exams)
B = 18; % upper bound on the number of bins (e.g., trivially, we can say one bin per item)
W = [301, 301, 301, 301, 301, 301, 701, 701, 701, 701, 701, 701, 1051, 1051, 1051, 1051, 1051, 1051]; % item resource usage (e.g., students)
C = 2100; % bin capacity (e.g., classroom capacity)

% Parameters
int: n;
int: B; 
int: C;
set of int: I = 1..B; % bin indexing
set of int: J = 1..n; % item indexing
set of int: IJ = 1..B*n; % bin/item pair indexing
array[J] of int: W;

% Define variables
array[I] of var 0..1: y; % y[i] = 1 if bin i is opened, 0 otherwise  
array[IJ] of var 0..1: x; % x[i][j] = 1 if item j placed in bin i, 0 otherwise
var int: Z; % number of bins used

% Lower bound on bins
constraint sum(i in I)(y[i]) >= 1; % You can change 1 to a provable lower bound! (as discussed in class)

% Capacity constraint
constraint forall(i in I)(
	sum(j in J)(W[j]*x[(i-1)*n + j]) <= C*y[i] % Items in each open bin cannot exceed capacity
	);

% Assignment constraint
constraint forall(j in J)(
	sum(i in I)(x[(i-1)*n + j]) == 1
	);

% Objective bounding 
constraint sum(i in I)(y[i]) == Z;

% Objective function
solve minimize Z;

% Solution output
output ["Number of bins used: ", show(Z), "; Item/bin assignment: ", show(x)]




