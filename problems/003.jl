"""
Problem 3: Largest prime factor

Published on: 02 November 2001 at 06:00 pm [Server Time]
Solved by: 563841
Difficulty Rating: 5%

Problem Description:
-------------------
The prime factors of 13195 are 5, 7, 13 and 29.

What is the largest prime factor of the number 600851475143?

Example:
--------
Example input and output.

Input: 13195
Output: 29

Solution:
---------
We will use Pollard's rho algorithm to find the prime factors of the number.
See: https://en.wikipedia.org/wiki/Pollard's_rho_algorithm

The last factor of the number will be the largest prime factor of the number.
"""

using Primes

function pollar_rho(n::Int64, x0::Int64=2)
    # we will use rho's algorithm to find the prime factors
    x = x0
    y = x
    d = 1

    g(Θ) = (Θ^2 + 1) % n

    # rho's algorithm
    while d == 1
        x = g(x)
        y = g(g(y))
        d = gcd(abs(x - y), n)
    end

    # rho's algorithm failed, return -1 to indicate failure
    if d == n
        return -1
    else
        # d is a non-trivial factor of n
        return d
    end
end

function solve_problem()
    n = 600851475143
    factors = Array{Int64}(undef, 0)
    x0 = 2

    # find the prime factors of n
    while n > 1

        # check if n is prime
        if isprime(n)
            push!(factors, n)
            break
        end

        # n is not prime, find a factor of n
        factor = pollar_rho(n, x0)
        if factor == -1
            # rho's algorithm failed, try again with a different x0
            x0 += 1
            continue
        end

        # print nice evenly spaced row of factor, n and x0
        println("factor: ", factor, " n: ", n, " x0: ", x0)

        # add the factor to the list of factors
        push!(factors, factor)

        # update n
        n = n ÷ factor
    end

    # print the largest prime factor
    println("Largest prime factor: ", factors[end])
end

# Test the solution with the given example
solve_problem()
