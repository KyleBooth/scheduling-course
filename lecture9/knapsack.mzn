% 0-1 Knapsack: MIP Model (MiniZinc implementation)
% Author: Kyle E. C. Booth (kbooth@mie.utoronto.ca)
% Usage: Scheduling Course

% Define problem instance 
n = 5;
w = [12, 1, 4, 3, 2];
v = [4, 2, 10, 1, 2];
C = 15; 

% Parameters
int: n; 
int: C;
set of int: I = 1..n;
array[I] of int: w;
array[I] of int: v;

% Define variables
array[I] of var 0..1: x;
var int: Z;

% Capacity constraint
constraint sum(i in I)(w[i]*x[i]) <= C;

% Objective bounding 
constraint sum(i in I)(v[i]*x[i]) == Z;

% Objective function
solve maximize Z;

% Solution output
output ["Knapsack value: ", show(Z), "; Item selections: ", show(x)]




