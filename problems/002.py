from math import sqrt, log, floor

# Golden ratio
ϕ = (1 + sqrt(5)) / 2

def n_largest(F):
    """
    Index of the largest Fibonacci number smaller than F
    """
    return floor(log(ϕ * F * sqrt(5)) / log(ϕ)) - 1

def fibonacci(n):
    """
    n-th Fibonacci number
    """
    return floor((ϕ**n - (-ϕ)**(-n)) / (2 * ϕ - 1))

def sum_even_fibonacci(F):
    """
    Sum of all the even Fibonacci numbers below F (F not included)
    """
    # find the index of the largest Fibonacci number smaller than F
    n = n_largest(F)

    # round down n to the nearest multiple of 3
    n -= n % 3

    # compute the sum of all the even Fibonacci numbers below n
    return (fibonacci(n + 2) - 1) // 2

def solve_problem(x=4e6):
    """
    Solve the problem for a given number n
    """
    return sum_even_fibonacci(x)

# Test the solution with the given example
print(solve_problem(4e6))
