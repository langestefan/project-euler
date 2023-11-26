"""
Problem 6: Sum Square Difference

Published on: 14 December 2001 at 06:00 pm [Server Time]
Solved by: 505401
Difficulty Rating: 5%

Problem Description:
-------------------
The sum of the squares of the first ten natural numbers is:
1^2 + 2^2 + ... + 10^2 = 385.

The square of the sum of the first ten natural numbers is
(1 + 2 + ... + 10)^2 = 55^2 = 3025.

Hence the difference between the sum of the squares of the first ten natural numbers and 
the square of the sum is: 3025 - 385 = 2640.

Find the difference between the sum of the squares of the first one hundred natural 
numbers and the square of the sum.

Example:
--------
Example input and output.

Solution:
---------
"""
function solve_problem(N::Int64=100)
    sum_of_squares = N*(N + 1)*(2N + 1) / 6
    square_of_sum = (N*(N + 1) / 2)^2
    return square_of_sum - sum_of_squares
end

# Test the solution with the given example
solve_problem()
