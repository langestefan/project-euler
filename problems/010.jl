"""
Problem 10: Summation of Primes

Published on: 08 February 2002 at 06:00 pm [Server Time]
Solved by: 337572
Difficulty Rating: 5%

Problem Description:
-------------------
The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.

Find the sum of all the primes below n.

Solution:
---------

We will be using the Sieve of Eratosthenes to solve this problem.
"""
function solve_problem(n::Int=2_000_000)
    integers = [true for i in 1:n]
    integers[1] = false
    primes = Int[]

    for i in 1:n
        if integers[i]
            push!(primes, i)
            for j in i:i:n
                integers[j] = false
            end
        end
    end

    println(sum(primes))
end

# Test the solution with the given example
solve_problem()
