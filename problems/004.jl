"""
Problem 4: Largest palindrome product

Published on: 16 November 2001 at 06:00 pm [Server Time]
Solved by: 499050
Difficulty Rating: 5%

Problem Description:
-------------------
A palindromic number reads the same both ways. The largest palindrome made from 
the product of two 2-digit numbers is 9009 = 91 x 99.

Find the largest palindrome made from the product of two 3-digit numbers.

Example:
--------
Input: 2
Output: 9009

Solution:
---------

We will be using MIP (Mixed Integer Programming) to solve this problem.

Let's say we have two 3-digit numbers, x and y, and we want to find the largest
palindrome made from the product of x and y.

The largest number two 3-digit numbers can make is 999 x 999 = 998001. Parametrically,
we can write this as:

P = 1e5 * a + 1e4 * b + 1e3 * c + 1e2 * d + 1e1 * e + f

where a, b, c, d, e, and f are integers between 0 and 9.

The optimization problem then becomes:

maximize    P
s.t.        P = 1e5 * a + 1e4 * b + 1e3 * c + 1e2 * d + 1e1 * e + f
            P = 1e5 * f + 1e4 * e + 1e3 * d + 1e2 * c + 1e1 * b + a
            a, b, c, d, e, f are integers between 0 and 9

The two constraints ensure that P is a palindrome by reversing the digits of P.

"""

using JuMP, GLPK, IterTools, Primes, LinearAlgebra

function solve_problem(n_digits::Int=3)
    # n_digits is the number of digits in the two numbers we are multiplying

    # create a model instance
    model = Model(GLPK.Optimizer)

    # define the variables
    @variable(model, 0 <= x[i=1:n_digits*2] <= 9, Int)
    @variable(model, 0 <= P <= sum(9 * 10^(i - 1) for i in 1:n_digits)^2)

    # P must be a palindrome constraint
    @constraint(model, P == sum(x[i] * 10^(i - 1) for i in 1:n_digits*2))
    @constraint(model, P == sum(x[i] * 10^(n_digits * 2 - i) for i in 1:n_digits*2))

    # Lower and upper bounds for P
    U = sum(9 * 10^(i - 1) for i in 1:n_digits)^2 
    # L = sum(10^(i - 1) for i in 1:n_digits)^2
    L = Int(9.0e5)

    # find all numbers between L and U that have a factorization of two n_digits numbers
    value_set = product(100:999, 100:999)
    value_set = [x[1] * x[2] for x in value_set if L <= x[1] * x[2] <= U]
    value_set = [x for x in value_set if isprime(x) == false]
    value_set = unique(value_set)
    println("Number of values in the set: ", length(value_set))

    # binary variable vector b
    b = @variable(model, [i=1:length(value_set)], Bin)

    # constraint that P must not be a prime number
    @constraint(model, dot(b, value_set) == P)
    @constraint(model, dot(b, ones(length(value_set))) == 1)

    # define objective function
    @objective(model, Max, P)

    # solve the optimization problem
    optimize!(model)

    # print the solution
    println("The largest palindrome product of two $n_digits-digit numbers is: ", Int(value(P)))

    # return the solution
    return value(P)
end

# Test the solution with the given example
solve_problem()
