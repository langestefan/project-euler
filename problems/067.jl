"""
Problem 67: Maximum Path Sum II

Published on: 9th April 2004 at 06:00 pm [Server Time]
Solved by: 101688
Difficulty Rating: 5%

Problem Description:
-------------------

By starting at the top of the triangle below and moving to adjacent numbers on the row below, 
the maximum total from top to bottom is 23.

      3
     7 4
    2 4 6
   8 5 9 3

That is, 3 + 7 + 4 + 9 = 23.

Find the maximum total from top to bottom in triangle.txt (right click and 'Save Link/Target As...'),
a 15K text file containing a triangle with one-hundred rows.

NOTE: This is a much more difficult version of Problem 18.
It is not possible to try every route to solve this problem, as there are 2^99 altogether!
If you could check one trillion (10^12) routes every second it would take over twenty billion years to check them all.
There is an efficient algorithm to solve it. ;o)

Solution:
---------
"""

using DelimitedFiles

# include problems\018.jl
include("018.jl")

# read the triangle from the file
triangle = readdlm("./resources/0067_triangle.txt")
triangle[triangle.==""] .= 0
triangle = Array{Int8}(triangle)

# test the solution with the given example
obj_val, X = solve_problem(triangle)
println("Maximum path sum: ", Int(obj_val))

# print the solution as a triangle
println("Selected path:")
print_triangle(triangle, X)
