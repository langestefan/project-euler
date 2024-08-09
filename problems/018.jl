"""
Problem 18: Maximum Path Sum I

Published on: 31st May 2002 at 06:00 pm [Server Time]
Solved by: 154373
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

Find the maximum total from top to bottom of the triangle below:

                            75
                          95  64
                        17  47  82
                      18  35  87  10
                    20  04  82  47  65
                  19  01  23  75  03  34
                88  02  77  73  07  63  67
              99  65  04  28  06  16  70  92
            41  41  26  56  83  40  80  70  33
          41  48  72  33  47  32  37  16  94  29
        53  71  44  65  25  43  91  52  97  51  14
      70  11  33  28  77  73  17  78  39  68  17  57
    91  71  52  38  17  14  91  43  58  50  27  29  48
  63  66  04  68  89  53  67  30  73  16  69  87  40  31

NOTE: As there are only 16384 routes, it is possible to solve this problem by trying every route.
However, Problem 67, is the same challenge with a triangle containing one-hundred rows; 
it cannot be solved by brute force, and requires a clever method!

Solution:
---------
"""

using BenchmarkTools
using JuMP
using HiGHS

triangle = [
  # x <- start 
  # | 
  75 00 00 00 00 00 00 00 00 00 00 00 00 00 00 # 1
  95 64 00 00 00 00 00 00 00 00 00 00 00 00 00 # 2
  17 47 82 00 00 00 00 00 00 00 00 00 00 00 00 # 3
  18 35 87 10 00 00 00 00 00 00 00 00 00 00 00 # 4
  20 04 82 47 65 00 00 00 00 00 00 00 00 00 00 # 5
  19 01 23 75 03 34 00 00 00 00 00 00 00 00 00 # 6
  88 02 77 73 07 63 67 00 00 00 00 00 00 00 00 # 7
  99 65 04 28 06 16 70 92 00 00 00 00 00 00 00 # 8
  41 41 26 56 83 40 80 70 33 00 00 00 00 00 00 # 9
  41 48 72 33 47 32 37 16 94 29 00 00 00 00 00 # 10
  53 71 44 65 25 43 91 52 97 51 14 00 00 00 00 # 11
  70 11 33 28 77 73 17 78 39 68 17 57 00 00 00 # 12
  91 71 52 38 17 14 91 43 58 50 27 29 48 00 00 # 13
  63 66 04 68 89 53 67 30 73 16 69 87 40 31 00 # 14
  04 62 98 27 23 09 70 98 73 93 38 53 60 04 23 # 15
  # 1 2 3  4  5  6  7  8  9  10 11 12 13 14 15 
  # |
  # y <- end
]

using Printf

function print_triangle(G, X)
  for i in 1:size(G, 1)
    print("  "^(size(G, 1) - i))

    for j in 1:i
      if X[i, j] == 1
        # Print selected values in red
        print("\e[31m")  # Start red color
        @printf(" %02d ", G[i, j])
        print("\e[0m")   # Reset color
      else
        @printf(" %02d ", G[i, j])
      end
    end
    println()
  end
end


function solve_problem(G)
  """
  Solve as a negative shortest (longest) path problem using linear programming
  """
  model = Model(HiGHS.Optimizer)
  (n, m) = size(G)

  # variables are arcs in the triangle, 1 if the arc is selected, 0 otherwise
  @variable(model, x[1:n, 1:n], Bin)

  # arcs in G == 0 are not visited since the node doesnt exist
  @constraint(model, [i = 1:n, j = 1:n; G[i, j] == 0], x[i, j] == 0)

  # we must select one arc per row
  @constraint(model, [i = 1:n], sum(x[i, j] for j = 1:i) == 1)

  # triangle constraint:
  # the arc (i, j) can only be selected if the arc (i-1, j-1) or (i-1, j) is selected
  # example: (5, 2) = 04 can only be selected if (4, 1) = 18 or (4, 2) = 35 is selected
  @constraint(model, [i = 2:n, j = 2:i], x[i, j] <= x[i-1, j-1] + x[i-1, j])

  # for the first column the arc (i, 1) can only be selected if (i-1, 1) is selected
  # (the first column has no left arc)
  @constraint(model, [i = 2:n], x[i, 1] <= x[i-1, 1])

  # objective is to maximize the sum of the selected arcs
  @objective(model, Max, sum(G[i, j] * x[i, j] for i = 1:n, j = 1:i))

  optimize!(model)

  return objective_value(model), value.(x)
end

# # test the solution with the given example
# obj_val, X = solve_problem(triangle)
# println("Maximum path sum: ", Int(obj_val))

# # print the solution as a triangle
# println("Selected path:")
# print_triangle(triangle, X)
