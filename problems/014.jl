"""
Problem 14: Longest Collatz Sequence

Published on: 5th April 2002 at 06:00 pm [Server Time]
Solved by: 239891
Difficulty Rating: 5%

Problem Description:
-------------------

The following iterative sequence is defined for the set of positive integers:

n → n/2 (n is even)
n → 3n + 1 (n is odd)

Using the rule above and starting with 13, we generate the following sequence:

13 → 40 → 20 → 10 → 5 → 16 → 8 → 4 → 2 → 1

It can be seen that this sequence (starting at 13 and finishing at 1) contains 10 terms.
Although it has not been proved yet (Collatz Problem), it is thought that all starting numbers finish at 1.

Which starting number, under one million, produces the longest chain?

Solution:
---------
"""

using BenchmarkTools


function collatz_sequence(N::Int64)
    """
    Generate the Collatz sequence for a given number n
    """
    # initialize the sequence length
    seq_length = zeros(Int64, N)

    # iterate over all numbers from 1 to n
    for i in 2:N
        count = 0
        x = i

        # calculate the sequence length
        while (x != 1 && x >= i)
            if x % 2 == 0
                x = x / 2
                count += 1
            else
                # use the shortcut version for odd numbers
                x = (3 * x + 1) / 2
                count += 2
            end
        end

        seq_length[i] = count + seq_length[Int(x)]
    end

    # find the number with the longest sequence
    max_number = argmax(seq_length)
    max_length = seq_length[max_number]

    return max_number, max_length
end

function solve_problem(n::Int64)
    """
    Solve the problem for a given number n
    """
    # calculate the Collatz sequence for each number
    max_number, max_length = collatz_sequence(n)

    println("The number with the longest Collatz sequence is $max_number with a length of $max_length")
end

# test the solution with the given example
@benchmark solve_problem(Int64(1e6))
