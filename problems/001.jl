"""
Problem 1: Multiples of 3 or 5

Published on: Friday, 5th October 2001, 06:00 pm
Solved by: 970256
Difficulty Rating: 5%

Problem Description:
-------------------
If we list all the natural numbers below 10 that are multiples of 3 or 5, we get 3, 5, 6 and 9. 
The sum of these multiples is 23.

Find the sum of all the multiples of 3 or 5 below 1000.

Example:
--------
Input: 10
Output: 23 (3 + 5 + 6 + 9)

Solution:
---------
We use the set of multiples of 3 and 5 to compute the sum of all the multiples of 3 or 5 below 1000.

This is given by the formula:

sum_3(n) U sum_5(n) = sum_3(n) + sum_5(n) - sum_3 ∩ sum_5(n)
                    = sum_3(n) + sum_5(n) - sum_15(n)

Where sum_k(n) is the sum of all the multiples of k below n.

Because the multiples of 15 are multiples of 3 and 5, we need to subtract them once.
"""

function sum_k_multiples(k::Int64, n::Int64)
    """
    Sum of all the multiples of k below n
    """
    p = floor(Int64, n / k)
    return k * p * (p + 1) // 2
end

function solve_problem(n::Int64=1000)
    """
    Solve the problem for a given number n
    """
    return sum_k_multiples(3, n - 1) + sum_k_multiples(5, n - 1) - sum_k_multiples(15, n - 1)
end

# Test the solution with the given example
solve_problem()
