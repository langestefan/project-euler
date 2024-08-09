"""
Problem 20: Factorial Digit Sum

Published on: 21st June 2002 at 06:00 pm [Server Time]
Solved by: 209655
Difficulty Rating: 5%

Problem Description:
-------------------

n! means n × (n − 1) × ... × 3 × 2 × 1

For example, 10! = 10 × 9 × ... × 3 × 2 × 1 = 3628800,
and the sum of the digits in the number 10! is 3 + 6 + 2 + 8 + 8 + 0 + 0 = 27.

Find the sum of the digits in the number 100!

Solution:
---------
"""


function solve_problem(n::Int64)
  """
  Solve the problem.
  """
  # k: number of digits
  # floor(log(n!)) = floor(log(n) + log(n-1) + log(n-2) + ... log(2)*log(1))
  k = floor(Int64, sum(log10.(1:n))) + 1

  # initialize the array
  digits = zeros(Int64, k)
  digits[1] = 1

  # calculate the factorial
  for i in 1:n
    carry = 0

    # apply multiplication to every digit
    for j in 1:k
      digits[j] = i * digits[j] + carry
      carry = 0

      # apply carry
      if digits[j] >= 10
        carry = div(digits[j], 10)
        digits[j] = digits[j] % 10
      end
    end
  end

  return sum(digits)
end

# solve the problem and print the result
solve_problem(100)