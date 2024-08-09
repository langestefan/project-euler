"""
Problem 25: 1000-digit Fibonacci number

Published on: 30th August 2002 at 06:00 pm [Server Time]
Solved by: 165062
Difficulty Rating: 5%

Problem Description:
-------------------

The Fibonacci sequence is defined by the recurrence relation:

    F(n) = F(n-1) + F(n-2), where F(1) = 1 and F(2) = 1.

Hence the first 12 terms will be:

    F(1) = 1
    F(2) = 1
    F(3) = 2
    F(4) = 3
    F(5) = 5
    F(6) = 8
    F(7) = 13
    F(8) = 21
    F(9) = 34
    F(10) = 55
    F(11) = 89
    F(12) = 144

The 12th term, F(12), is the first term to contain three digits.

What is the index of the first term in the Fibonacci sequence to contain n digits?

Solution:
---------
"""



function solve_problem(n::Int64)
  """
  Solve the problem.
  """
  # golden ratio
  ϕ = (1 + sqrt(5)) / 2

  # use the approximation of the Fibonacci number index
  # F(n) = ϕ^n / sqrt(5)
  # nr_digits(F(n)) = n * log(ϕ) - log(5) + 1

  # find the index of the first Fibonacci number with n digits
  n_digits = (n - 1 + log10(sqrt(5))) / log10(ϕ)
  n_digits = ceil(Int64, n_digits)

  # return the index
  return n_digits
end

# solve the problem and print the result
solve_problem(1000)