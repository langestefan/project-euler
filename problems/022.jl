"""
Problem 22: Names Scores

Published on: 19th July 2002 at 06:00 pm [Server Time]
Solved by: 143045
Difficulty Rating: 5%

Problem Description:
-------------------

Using names.txt (right click and 'Save Link/Target As...'), a 46K text file 
containing over five-thousand first names, begin by sorting it into alphabetical order. 

Then working out the alphabetical value for each name, multiply this value by its 
alphabetical position in the list to obtain a name score.

For example, when the list is sorted into alphabetical order, COLIN, which is worth
3 + 15 + 12 + 9 + 14 = 53, is the 938th name in the list. So, COLIN would obtain
a score of 938 × 53 = 49714.

What is the total of all the name scores in the file?

Solution:
---------
"""

using DelimitedFiles

# read the file content
names = readchomp("./resources/0022_names.txt")
names = string.(split(replace(names, "\"" => ""), ","))


function solve_problem(names::Array{String,1})
  """
  Solve the problem.
  """
  # sort the names
  sort!(names)

  # calculate the name scores
  total_score = 0

  for (i, name) in enumerate(names)
    # calculate the name score
    total_score += i * sum(Int(c) - 64 for c in name)
  end

  return total_score
end

# solve the problem and print the result
solve_problem(names)