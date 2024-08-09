"""
Problem 17: Number Letter Counts

Published on: 17th May 2002 at 06:00 pm [Server Time]
Solved by: 161189
Difficulty Rating: 5%

Problem Description:
-------------------

If the numbers 1 to 5 are written out in words: one, two, three, four, five, then there are
3 + 3 + 5 + 4 + 4 = 19 letters used in total.

If all the numbers from 1 to 1000 (one thousand) inclusive were written out in words, how many
letters would be used?

NOTE: Do not count spaces or hyphens. For example, 342 (three hundred and forty-two) contains
23 letters and 115 (one hundred and fifteen) contains 20 letters. The use of "and" when writing
out numbers is in compliance with British usage.

Solution:
---------
"""

using BenchmarkTools


mapping_words = Dict(
    1 => "one",
    2 => "two",
    3 => "three",
    4 => "four",
    5 => "five",
    6 => "six",
    7 => "seven",
    8 => "eight",
    9 => "nine",
    10 => "ten",
    11 => "eleven",
    12 => "twelve",
    13 => "thirteen",
    14 => "fourteen",
    15 => "fifteen",
    16 => "sixteen",
    17 => "seventeen",
    18 => "eighteen",
    19 => "nineteen",
    20 => "twenty",
    30 => "thirty",
    40 => "forty",
    50 => "fifty",
    60 => "sixty",
    70 => "seventy",
    80 => "eighty",
    90 => "ninety",
    100 => "hundred",
    1000 => "thousand"
)

word_len = Dict([num => length(word) for (num, word) in mapping_words])


function number_to_word(n::Int64)
    """
    Convert a number to a word
    """
    # deconstruct number
    ones = n % 10
    tens = n % 100 - ones
    hundreds = n % 1000 - tens - ones
    thousands = n % 10000 - hundreds - tens - ones

    # convert to words
    word = ""

    # 1000's
    if thousands > 0
        word *= mapping_words[thousands//1000] * mapping_words[1000]
    end

    # 100's
    if hundreds > 0
        word *= mapping_words[hundreds//100] * mapping_words[100]
    end

    # 10's
    if tens > 0
        if hundreds > 0 || thousands > 0
            word *= "and"
        end
        if n % 100 in keys(mapping_words)
            word *= mapping_words[n%100]
        else
            word *= mapping_words[tens]
            if ones > 0
                word *= mapping_words[ones]
            end
        end
    else
        if ones > 0
            if hundreds > 0 || thousands > 0
                word *= "and"
            end
            word *= mapping_words[ones]
        end
    end

    return word
end

function solve_problem(n::Int64)
    """
    Solve the problem for a given number n
    """
    words = number_to_word.(1:n)
    return sum(length.(words))
end

# test the solution with the given example
# @benchmark solve_problem(1000)
println(solve_problem(1000))
