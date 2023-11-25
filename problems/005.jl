"""
Problem 5: Smallest multiple

Published on: 30 November 2001 at 06:00 pm [Server Time]
Solved by: 502204
Difficulty Rating: 5%

Problem Description:
-------------------
2520 is the smallest number that can be divided by each of the numbers from 1 to 10 
without any remainder.

What is the smallest positive number that is evenly divisible with no remainder by all 
of the numbers from 1 to 20?

Example:
--------
Input 1: 10
Output 1: 2520

Solution:
---------
"""
function solve_problem(n::Int64=20)
    # We will use the prime factorization of the numbers from 1 to n to find the 
    # smallest number that is evenly divisible by all of them.
    # See: https://en.wikipedia.org/wiki/Least_common_multiple#Finding_least_common_multiples_by_prime_factorization

    # find the prime factors of the numbers from 1 to n
    factors = Dict{Int64, Int64}()
    for i in 1:n
        # find the prime factors of i
        prime_factors = factor(i)
        println("prime factors of ", i, ": ", prime_factors)

        # update the factors dictionary
        for (p, e) in prime_factors
            if haskey(factors, p)
                factors[p] = max(factors[p], e)
            else
                factors[p] = e
            end
        end
    end

    # find the smallest number that is evenly divisible by all of the numbers from 1 to n
    result = 1
    for (p, e) in factors
        result *= p^e
    end
    println("factors: ", factors)

    return result
end

# Test the solution with the given example
solve_problem()
