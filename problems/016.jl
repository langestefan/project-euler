"""
Problem 16: Power Digit Sum

Published on: 3rd May 2002 at 06:00 pm [Server Time]
Solved by: 242197
Difficulty Rating: 5%

Problem Description:
-------------------

2^15 = 32768 and the sum of its digits is 3 + 2 + 7 + 6 + 8 = 26.

What is the sum of the digits of the number 2^1000?

Solution:
---------
"""

using BenchmarkTools



function solve_problem(n::Int64)
    """
    Solve the problem for a given number n
    """
    # k: number of digits
    k = floor(Int64, n * log10(2)) + 1

    # initialize the array
    digits = zeros(Int64, k)
    digits[1] = 1

    # calculate the power
    for i in 1:n
        carry = 0
        for j in 1:k
            digits[j] = 2 * digits[j] + carry
            carry = 0
            if digits[j] >= 10
                carry = 1
                digits[j] -= 10
            end
        end
    end

    return sum(digits)
end

# test the solution with the given example
@benchmark solve_problem(1000)
println(solve_problem(1000))
