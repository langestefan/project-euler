"""
Problem 2: Even Fibonacci Numbers

Published on: Friday 19th October 2001, 06:00 pm
Solved by: 782702
Difficulty Rating: 5%

Problem Description:
-------------------
Each new term in the Fibonacci sequence is generated by adding the previous two terms. 
By starting with 1 and 2, the first 10 terms will be:

    1, 2, 3, 5, 8, 13, 21, 34, 55, 89, ...

By considering the terms in the Fibonacci sequence whose values do not exceed four million, 
find the sum of the even-valued terms.

Example:
--------
Example input and output.

Input: 10
Output: 44 (2 + 8 + 34)

Solution:
---------

The goal is to find the sum of all the even Fibonacci numbers below a given value F.

We will make use of the following mathematical properties:
- The sum of the first n Fibonacci numbers is given by F(n + 2) - 1
- Every third Fibonacci number is even

Which gives the following identity:
- sum_even(F(n)) = sum(F(n)) / 2 = (F(n + 2) - 1) / 2

Where n must be a multiple of 3. Hence we need to make sure we round down n 
to the nearest multiple of 3 before computing the sum. We will do this by subtracting n mod 3.

Futhermore, we will use the formula given on the Wikipedia page for Fibonacci numbers
to compute the index of the first Fibonacci number smaller than F.
(source: https://en.wikipedia.org/wiki/Fibonacci_number#Computation_by_rounding)

n_largest(F) = floor(log(ϕ * F * sqrt(5)) / log(ϕ)) - 1

Where ϕ is the golden ratio (ϕ = (1 + sqrt(5)) / 2).

This solution method has complexity O(1), because the number of operations is constant for any F.

The solution gives: 
`solve_problem(Int64(4e6)) = 4613732`
"""

ϕ = (1 + sqrt(5)) / 2

function n_largest(F)
    """
    Index of the largest Fibonacci number smaller than F
    """
    return floor(Int64, log(ϕ * F * sqrt(5)) / log(ϕ)) - 1
end

function fibonacci(n::Int64)
    """
    n-th Fibonacci number
    """
    return floor(Int64, (ϕ^n - (-ϕ)^(-n)) / (2ϕ - 1))
end

function sum_even_fibonacci(F)
    """
    Sum of all the even Fibonacci numbers below F (F not included)
    """
    # find the index of the largest Fibonacci number smaller than F
    n = n_largest(F)

    # round down n to the nearest multiple of 3
    n -= n % 3

    # compute the sum of all the even Fibonacci numbers below n
    return (fibonacci(n + 2) - 1) / 2
end

function solve_problem(x::Int64=Int64(4e6))
    """
    Solve the problem for a given number n
    """
    return sum_even_fibonacci(x)
end

# Test the solution with the given example
solve_problem(Int64(4e6))
