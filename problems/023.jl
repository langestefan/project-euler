"""
Problem 23: Non Abundant Sums

Published on: 2nd August 2002 at 06:00 pm [Server Time]
Solved by: 111634
Difficulty Rating: 5%

Problem Description:
-------------------

A perfect number is a number for which the sum of its proper divisors is exactly equal 
to the number.

For example, the sum of the proper divisors of 28 would be 1 + 2 + 4 + 7 + 14 = 28, 
which means that 28 is a perfect number.

A number n is called deficient if the sum of its proper divisors is less than n and
it is called abundant if this sum exceeds n.

As 12 is the smallest abundant number, 1 + 2 + 3 + 4 + 6 = 16, the smallest number
that can be written as the sum of two abundant numbers is 24. By mathematical analysis,
it can be shown that all integers greater than 28123 can be written as the sum of two
abundant numbers. However, this upper limit cannot be reduced any further by analysis
even though it is known that the greatest number that cannot be expressed as the sum of
two abundant numbers is less than this limit.

Find the sum of all the positive integers which cannot be written as the sum of two
abundant numbers.

Solution:
---------
"""

function d(x::Int64)
  """
  Sum the divisors of x
  """
  count = 0

  for i in 1:floor(Int64, sqrt(x))
    if x % i == 0
      count += i

      # check for perfect squares
      if i != x / i

        # if x divides i, then x / i divides x
        count += x / i
      end
    end
  end

  # proper divisors only, so subtract x
  return count - x
end

function is_abundant(x::Int64)
  """
  Check if x is an abundant number
  """
  return d(x) > x
end

function solve_problem(n::Int64)
  """
  Solve the problem.
  """
  # find all abundant numbers less than n
  abundant = filter(is_abundant, 1:n)

  # find all numbers that can be written as the sum of two abundant numbers
  sum_abundant = Set{Int64}()

  for i in abundant
    for j in abundant
      if i + j <= n
        push!(sum_abundant, i + j)
      end
    end
  end

  # find all numbers that cannot be written as the sum of two abundant numbers
  non_abundant = setdiff(Set{Int64}(1:n), sum_abundant)

  # return the sum of all non-abundant numbers
  return sum(non_abundant)
end

# solve the problem and print the result
solve_problem(28123)