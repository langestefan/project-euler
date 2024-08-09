"""
Problem 15: Lattice Paths

Published on: 19th April 2002 at 06:00 pm [Server Time]
Solved by: 198332
Difficulty Rating: 5%

Problem Description:
-------------------

Starting in the top left corner of a 2×2 grid, and only being able to move to the right 
and down, there are exactly 6 routes to the bottom right corner.

How many such routes are there through a 20×20 grid?

Solution:
---------
"""

using BenchmarkTools



function solve_problem(n::Int64)
    """
    Solve the problem for a given number n
    """
    # initialize the grid
    grid = zeros(Int64, n + 1, n + 1)

    # initialize the first row and column
    for i in 1:n+1
        grid[i, 1] = 1
        grid[1, i] = 1
    end

    # calculate the number of paths for each cell
    for i in 2:n+1
        for j in 2:n+1
            grid[i, j] = grid[i-1, j] + grid[i, j-1]
        end
    end

    return grid[n+1, n+1]
end

# test the solution with the given example
# @benchmark solve_problem(20)

println(solve_problem(20))
