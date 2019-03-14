% Bin Packing: CP Model (MiniZinc implementation)
% Author: Kyle E. C. Booth (kbooth@mie.utoronto.ca)
% Usage: Scheduling Course

% Include the required global constraint
include "bin_packing.mzn";

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
array[J] of int: W;

% Define variables
array[J] of var 1..B: y; % y[i] = the bin # that item i is placed in, ranging from: [1, B]

% Capacity constraint
constraint bin_packing(C, y, W);

% Objective function
solve minimize max(y);

% Solution output
output ["Number of bins used: ", show(max(y))]




