"""
Problem 7: 10001st Prime

Published on: 28 December 2001 at 06:00 pm [Server Time]
Solved by: 432724
Difficulty Rating: 5%

Problem Description:
-------------------
By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see
that the 6th prime is 13.

What is the 10001st prime number?
"""

using Primes

function solve_problem(n::Int64=10001)
    count = 0
    i = 1
    while count < n
        i += 1
        if isprime(i)
            count += 1
        end
    end
    return i
end

# Test the solution with the given example
solve_problem()
