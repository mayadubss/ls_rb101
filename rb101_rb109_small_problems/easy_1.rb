# Easy 1 Small Problems

# Repeat Yourself
# Write a method that takes two arguments, a string and a positive integer, and prints the string as many times as the integer indicates.
# P: input is a string and integer, output is string the number of times of the integer
# E: input "hi" 3 output hi hi hi, input "yes" 0 output is nothing
# D: input is a string and integer, output is a string
# A: define method with string and integer parameters
    # integer number of times print the string
# C:
def say_something(string, num)
  num.times {puts string}
end

say_something("hi", 3)
say_something("yes", 0)

# Odd
# P: Write a method that takes one integer that can be positive negative or zero and returns true if the absolute value is odd. False otherwise.
# E: 1 is true, -1 is true, 0 is fale, 4 is false
# D: input is an integer, output is a boolean
# A: define the method that takes one integer
    # convert the integer to a positive value
    # if modulo 2 of integer is 1 return true
    # otherwise return false
# C:
def is_odd?(int)
  pos_int = Integer.sqrt((int) ** 2)
  pos_int % 2 == 1 # no need to make an if statement for a true/false, the return value is already the last evaluated line of code
end

puts is_odd?(2)    # => false
puts is_odd?(5)    # => true
puts is_odd?(-17)  # => true
puts is_odd?(-8)   # => false
puts is_odd?(0)    # => false
puts is_odd?(7)    # => true
# Modulo operator always returns sign of the umber on the right so finding absolute value was not necessary
# Remainder uses sign of number on the left

# List of Digits
# P: Write a method that takes one positive integer and returns a list of every digit in the number
# E: Input 1234 output [1, 2, 3, 4], input 555 output [5, 5, 5], input 8 output [8]
# D: Input is an integer, output is an array
# A: define the method that takes one integer
    # convert the number to a sring
    # split the string into an array of each character (number)
    # convert the element at each index back to an integer
# C:
def digit_list(num)
  arr = num.to_s.split("") # .split on its own uses white space to split on, must include the empty quotes to split every character
  arr.map!{|x| x.to_i} # this could even be tacked on the end of the line before
end
puts digit_list(12345) == [1, 2, 3, 4, 5]     # => true
puts digit_list(7) == [7]                     # => true
puts digit_list(375290) == [3, 7, 5, 2, 9, 0] # => true
puts digit_list(444) == [4, 4, 4]             # => true

# How Many?
# P: write a method that returns the number of occurrences of each element in an array. Words are case sensitive.
# E: input [a, a, a, b, b, c] output a => 3, b => 2, c => 1; input [a, A, a] output a => 2, A => 1
# D: input is an array, output is a hash
# A: define a method that takes one array parameter
    # create an empty hash
    # loop through every element in the array
      # if the hash already has a key that matches the element, increment the value
      # otherwise add the key to the hash with a value of 1
    # iterate through the hash to print it in the desired format "a => 1"
# C:
vehicles = [
  'caR', 'cAr', 'truck', 'car', 'SUV', 'truck',
  'motorcycle', 'motorcycle', 'car', 'truck', 'suv'
]

def count_occurrences(array)
  h = {}
  array.each do |element|
    if h.has_key?(element.downcase) # for case sensitive, remove .downcase in lines 78, 79, and 81
      h[element.downcase] += 1
    else
      h[element.downcase] = 1
    end
  end
  h.each{|k, v| puts "#{k} => #{v}"}
end

count_occurrences(vehicles)
# another useful method, used in the solution is array.count(element)

# Reverse It (Part 1)
# P: write a method that takes a string as input and prints the string with the words in reverse order
# E: examples shown below
# D: input is a string and output is a string
# A: define a method that takes one string as an argument
    # create an array of the string split by white space
    # create a counter whose value is the length of the array
    # loop until the counter is equal to zero
    # define a new string by recursively adding the element at the counter - 1 index to the new string
    # subtract 1 from the counter
# C:
def reverse_sentence(str)
  words = str.split
  count = words.length
  rev_str = "#{words[count - 1]}"
  count -= 1
  until count <= 0 do
    rev_str = "#{rev_str} #{words[count - 1]}"
    count -= 1
  end
  rev_str
end

puts reverse_sentence('') == '' # => true
puts reverse_sentence('Hello World') == 'World Hello' # => true
puts reverse_sentence('Reverse these words') == 'words these Reverse' # => true
# methods to learn are array.reverse and array.join to join string elements into one string

# Reverse It (Part 2)
# P: write a method that takes a string of one or more words and outputs the same string but with any word with 5+ characters spelled in reverse
# E: given below, 
# D: input is a string and output is a string
# A: define method that takes one string as an argument
    # split the string into an array of words
    # for each word in the array
      # check if the word has 5+ letters
      # if it does, reverse the word
      # if is doesn't, leave it
    # join the array back into a string and return it
# C:
def reverse_words(sentence)
  sentence.split(" ").map!{|word| if word.length >= 5
                                    word.reverse
                                  else
                                    word
                                  end}.join(" ")
end

puts reverse_words('Professional')          # => lanoisseforP
puts reverse_words('Walk around the block') # => Walk dnuora the kcolb
puts reverse_words('Launch School')         # => hcnuaL loohcS

# Stringy Strings
# P: write a method that takes a positive integer and returns a string of 1's and 0's, always starting with 1, where the length of the string is equal to the integer
# E: examples below. edge case: if 0 is given, return an empty string ''
# D: input is a positive integer, output is a string
# A: define a method that takes an integer as an argument
    # define an empty string
    # for a number of iterations equal to the integer
    # append the integer modulo 2, converted to a string, to the empty string
# C:
def stringy(num)
  s = ""
  i = 1
  while i <= num
    s << (i % 2).to_s
    i += 1
  end
  s
end

#further exploration (starting with the launch school solution)
def stringy(size, first = 1)
  numbers = []

  size.times do |index|
    if first == 1
      number = index.even? ? 1 : 0
    elsif first == 0
      number = index.even? ? 0 : 1
    end
    numbers << number
  end

  numbers.join
end

puts stringy(6) == '101010' # => true
puts stringy(9) == '101010101' # => true
puts stringy(4, 0) == '0101' # => true
puts stringy(7, 0) == '0101010' # => true

# Array Average
# P: write a method that takes an array of positive integers, never empty, and returns the average of the integers in the array
# E: [1, 2, 3] => 2
# D: input is an array, output is an integer
# A: define a method that takes one input
    # take the sum of the array and divide it by the length of the array
# C:
def average(a)
  a.sum/a.length.to_f
end

puts average([1, 6]) == 3 # integer division: (1 + 6) / 2 -> 3
puts average([1, 5, 87, 45, 8, 8]) == 25
puts average([9, 47, 23, 95, 16, 52]) == 40

# Sum of Digits
# P: write a method that takes an integer and returns the sum of its digets.
# E: 123 => 6, 34_123 => 13, integer in form 123_456 is still just seen as 123456
# D: input is an integer, output is an integer
# A: definte a method that takes an integer as an argument
    # create an answer variable equal to zero
    # convert the integer to a string and split the string into an array
    # for every entry in the array convert it to an integer and add it to the answer variable
    # return the answer variable
# C:
def sum(num)
  tot = 0
  arr = num.to_s.split("")
  arr.each do |str|
    tot += str.to_i
  end
  tot
end

puts sum(23) == 5
puts sum(496) == 19
puts sum(123_456_789) == 45

# What's my Bonus?
# P: write a method that takes a salary and a boolean and calculates the bonus. the bonus is half the salary if true and 0 if false.
# E: (100, true) => 50, (100, false) => 0
# D: input is an integer and a boolean, output is an integer
# A: define a method that takes an integer and a boolean as arguments
# C: 
def calculate_bonus(salary, bonus)
  if bonus
    salary/2
  else
    0
  end
end

#OR ternary operator
def calculate_bonus(salary, bonus)
  bonus ? salary/2 : 0
end

puts calculate_bonus(2800, true) == 1400
puts calculate_bonus(1000, false) == 0
puts calculate_bonus(50000, true) == 25000