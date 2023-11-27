"""
Problem 9: Special Pythagorean Triplet

Published on: 25 January 2002 at 06:00 pm [Server Time]
Solved by: 367988
Difficulty Rating: 5%

Problem Description:
-------------------
A Pythagorean triplet is a set of three natural numbers, a < b < c, for which,
a^2 + b^2 = c^2

For example, 3^2 + 4^2 = 5^2, 9 + 16 = 25.

There exists exactly one Pythagorean triplet for which a + b + c = 1000.
Find the product abc.

"""

function solve_problem()
    # euclid's formula for generating pythagorean triples
    # https://en.wikipedia.org/wiki/Pythagorean_triple#Generating_a_triple
    # m > n > 0
    a(m, n) = m^2 - n^2
    b(m, n) = 2 * m * n
    c(m, n) = m^2 + n^2

    # we know that a + b + c = 1000
    # so we can solve for m and n
    n_iter = 0
    m = -1
    n = -1

    for m in 1:25
        for n in 1:m
            println("m = $m, n = $n")
            n_iter += 1
            if m * (m + n) == 500
                println("m = $m")
                println("n = $n")
                println("a = $(a(m, n))")
                println("b = $(b(m, n))")
                println("c = $(c(m, n))")
                println("a + b + c = $(a(m, n) + b(m, n) + c(m, n))")
                println("a * b * c = $(a(m, n) * b(m, n) * c(m, n))")
                println("n_iter = $n_iter")
                return
            end
        end
    end
end

# Test the solution with the given example
solve_problem()
