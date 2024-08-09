"""
Problem 21: Amicable Numbers

Published on: 5th July 2002 at 06:00 pm [Server Time]
Solved by: 155655
Difficulty Rating: 5%

Problem Description:
-------------------

Let d(n) be defined as the sum of proper divisors of n (numbers less than n which divide evenly into n).

If d(a) = b and d(b) = a, where a ≠ b, then a and b are an amicable pair and each of a and b are called
amicable numbers.

For example, the proper divisors of 220 are 1, 2, 4, 5, 10, 11, 20, 22, 44, 55 and 110; therefore d(220) = 284.
The proper divisors of 284 are 1, 2, 4, 71 and 142; so d(284) = 220.

Evaluate the sum of all the amicable numbers under 10000.

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


function solve_problem(n::Int64)
  """
  Solve the problem.
  """
  amicable = 0

  for a in 1:n
    b = Int(d(a))

    # check if a and b are amicable
    if a != b && d(b) == a
      amicable += a
    end
  end

  return amicable
end

# solve the problem and print the result
solve_problem(10000)