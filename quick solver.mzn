%a quick sudoku solver, based on the code at 
%https://verificationglasses.wordpress.com/2020/09/17/sudoku-minizinc/
%it has been generalised to n x n sudokus to make more useful
%the manual constraints represent the problem 'sudoku' provided to the player

int: SIZE  = 4; %adjust for different size sudoku, 4 x 4 etc
set of int: RANGE = 1..SIZE*SIZE; %in a 3 x 3 sudoku you can only have elements 1 to 9
array[RANGE, RANGE] of var RANGE: sudoku;
array[RANGE] of RANGE: first_i = [((k-1) div SIZE)*SIZE + 1| k in RANGE]; % first i in each square
array[RANGE] of RANGE: first_j = [((k-1) mod SIZE)*SIZE + 1| k in RANGE]; % first j in each square

include "alldifferent.mzn"; %means there is a constraint of that all elements of this collection must be different
constraint forall(i in RANGE)(alldifferent([sudoku[i,j] | j in RANGE])); % each row must contain alldifferent elements
constraint forall(j in RANGE)(alldifferent([sudoku[i,j] | i in RANGE])); % each col must contain all different elements
constraint forall(k in RANGE)(alldifferent([sudoku[i,j] | i in first_i[k]..first_i[k]+2, j in first_j[k]..first_j[k]+2])); % each box must contain all different elements

%you can hard code in the different cells, or as a preferential table, I will add this later if required
constraint sudoku[1,1] = 5;

output [show([sudoku[i,j]| j in RANGE]) ++ "\n"| i in RANGE];

solve satisfy;