"""
Problem 24: Lexicographic Permutations

Published on: 16th August 2002 at 06:00 pm [Server Time]
Solved by: 122369
Difficulty Rating: 5%

Problem Description:
-------------------

A permutation is an ordered arrangement of objects. For example, 3124 is one possible
permutation of the digits 1, 2, 3 and 4. If all of the permutations are listed numerically
or alphabetically, we call it lexicographic order. The lexicographic permutations of
0, 1 and 2 are:

012   021   102   120   201   210

What is the millionth lexicographic permutation of the digits:

0, 1, 2, 3, 4, 5, 6, 7, 8 and 9?

Solution:
---------
"""

using BenchmarkTools

function next_perm(a::Array{Int64,1})
  """
  Generate the next permutation of a
  """
  n = length(a)
  k = -1

  # find the largest index k such that a[k] < a[k + 1]
  for i in n-1:-1:1
    if a[i] < a[i+1]
      k = i
      break
    end
  end

  # if no such index exists, then this is the last permutation
  if k == -1
    return a
  end

  # find the largest index l greater than k such that a[k] < a[l]
  l = -1
  for i in n:-1:k+1
    if a[k] < a[i]
      l = i
      break
    end
  end

  # swap the value of a[k] with that of a[l]
  a[k], a[l] = a[l], a[k]

  # reverse the sequence from a[k + 1] up to and including the final element a[n]
  reverse!(a, k + 1)

  return a
end


function solve_problem(n::Int64)
  """
  Solve the problem.
  """
  # initialize the list of digits
  digits = collect(0:9)

  # generate the n-th permutation
  for i in 1:n-1
    next_perm(digits)
  end

  return join(string.(digits))
end

# solve the problem and print the result
solve_problem(Int64(1e6))
@benchmark solve_problem(Int64(1e6))