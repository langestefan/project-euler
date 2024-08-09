"""
Problem 19: Counting Sundays

Published on: 14th June 2002 at 06:00 pm [Server Time]
Solved by: 143328
Difficulty Rating: 5%

Problem Description:
-------------------

You are given the following information, but you may prefer to do some research for yourself.

1 Jan 1900 was a Monday.
Thirty days has September,
April, June and November.
All the rest have thirty-one,
Saving February alone,
Which has twenty-eight, rain or shine.
And on leap years, twenty-nine.

A leap year occurs on any year evenly divisible by 4, but not on a century unless it is divisible by 400.

How many Sundays fell on the first of the month during the twentieth century (1 Jan 1901 to 31 Dec 2000)?

Solution:
---------
"""

using Dates


function solve_problem_lazy()
  """
  Solve the problem in the laziest way possible.
  """
  # initialize the counter
  count = 0

  # loop over the years
  for year in 1901:2000
    # loop over the months
    for month in 1:12
      # check if the first day of the month is a Sunday
      if dayofweek(Date(year, month, 1)) == 7
        count += 1
      end
    end
  end

  # print the result
  println("Number of Sundays that fell on the first of the month during the twentieth century: ", count)
end


function solve_problem_but_work_for_it()
  """
  Solve the problem without using the builtin datetime functionality.
  """
  # initialize the counter
  count = 0

  # current date
  day = 1
  month = 1
  year = 1900

  # current day of the week
  # 1 Jan 1900 was a Monday
  day_of_week = 1

  # loop over the years
  while year < 2001
    # check if the first day of the month is a Sunday
    if year > 1900 && day_of_week == 7 && day == 1
      count += 1
    end

    # move to the next day
    day_of_week = (day_of_week % 7) + 1

    # move to the next month
    if month in [1, 3, 5, 7, 8, 10, 12]
      if day == 31
        day = 1
        month += 1
      else
        day += 1
      end
    elseif month in [4, 6, 9, 11]
      if day == 30
        day = 1
        month += 1
      else
        day += 1
      end
    elseif month == 2
      if year % 4 == 0 && (year % 100 != 0 || year % 400 == 0)
        if day == 29
          day = 1
          month += 1
        else
          day += 1
        end
      else
        if day == 28
          day = 1
          month += 1
        else
          day += 1
        end
      end
    end

    # move to the next year
    if month == 13
      month = 1
      year += 1
    end
  end

  # print the result
  println("Number of Sundays that fell on the first of the month during the twentieth century: ", count)
end

# lazy, just use builtin datetime functionality
solve_problem_lazy()

# work for it, without using builtin datetime functionality
solve_problem_but_work_for_it()
