# RB101-RB109 Small Problems - Medium 1
require 'pry'

# Rotation (Part 1)
=begin
Write a method that rotates an array by moving the first element to the end of the array.
The original array should not be modified.
Do not use the method Array#rotate or Array#rotate! for your implementation.
=end
def rotate_array(arr)
  rotated_arr = []
  (1..arr.size - 1).each do |index|
    rotated_arr << arr[index]
  end
  rotated_arr << arr[0]
end

p rotate_array([7, 3, 5, 2, 9, 1]) == [3, 5, 2, 9, 1, 7]
p rotate_array(['a', 'b', 'c']) == ['b', 'c', 'a']
p rotate_array(['a']) == ['a']

x = [1, 2, 3, 4]
puts rotate_array(x) == [2, 3, 4, 1]   # => true
puts x == [1, 2, 3, 4]                 # => true

# Further Exploration:
def rotate_string(str)
  rotate_array(str.split('')).join
end
p rotate_string("hello")
p rotate_string('hi my name is maya')
p rotate_string("105")

def rotate_integer(int)
  rotate_string(int.to_s).to_i
end
p rotate_integer(98765432)
p rotate_integer(34)

# Rotation (Part 2)
=begin
Write a method that can rotate the last n digits of a number.
Note that rotating just 1 digit results in the original number being returned.
You may use the rotate_array method from the previous exercise if you want. (Recommended!)
You may assume that n is always a positive integer.
=end
def rotate_rightmost_digits(num, n)
  arr_not_rotate = num.to_s.chars[0...-n]
  arr_to_rotate = num.to_s.chars[-n..-1]
  rotated_arr = rotate_array(arr_to_rotate)
  (arr_not_rotate + rotated_arr).join.to_i
end

def rotate_rightmost_letters(str, n)
  str_not_rotate = str[0...-n]
  str_to_rotate = str[-n..-1]
  rotated_str = rotate_string(str_to_rotate)
  str_not_rotate + rotated_str
end

puts rotate_rightmost_digits(735291, 1) == 735291
puts rotate_rightmost_digits(735291, 2) == 735219
puts rotate_rightmost_digits(735291, 3) == 735912
puts rotate_rightmost_digits(735291, 4) == 732915
puts rotate_rightmost_digits(735291, 5) == 752913
puts rotate_rightmost_digits(735291, 6) == 352917
puts rotate_rightmost_letters("10005", 5)

# Rotation (Part 3)
=begin
If you take a number like 735291, and rotate it to the left, you get 352917.
If you now keep the first digit fixed in place, and rotate the remaining digits, you get 329175.
Keep the first 2 digits fixed in place and rotate again to 321759.
Keep the first 3 digits fixed in place and rotate again to get 321597.
Finally, keep the first 4 digits fixed in place and rotate the final 2 digits to get 321579.
The resulting number is called the maximum rotation of the original number.
Write a method that takes an integer as argument, and returns the maximum rotation of that argument.
You can (and probably should) use the rotate_rightmost_digits method from the previous exercise.
Note that you do not have to handle multiple 0s.
  - rotate whole number
  - rotate rightmost(num, size of num)
  - rotate rightmost(num, size of num - 1)
  - keep going until 2
=end
def max_rotation(num)
  count = num.to_s.length
  ans = num
  until count < 2 do
    ans = rotate_rightmost_digits(ans, count)
    count -= 1
  end
  ans
end

puts max_rotation(735291) == 321579
puts max_rotation(3) == 3
puts max_rotation(35) == 53
puts max_rotation(105) == 15 # the leading zero gets dropped
puts max_rotation(8_703_529_146) == 7_321_609_845

# Further Exploration:
=begin
Assume you do not have the rotate_rightmost_digits or rotate_array methods.
How would you approach this problem? Would your solution look different?
Does this 3 part approach make the problem easier to understand or harder?
-> The 3 part approach makes the problem easier to understand, by breaking it down into the necessary actions

There is an edge case in our problem when the number passed in as the argument has multiple consecutive zeros.
Can you create a solution that preserves zeros?
=end
def max_rotation_string(str)
  count = str.to_s.size
  ans = str.to_s
  until count < 2 do
    ans = rotate_rightmost_letters(ans, count)
    count -= 1
  end
  ans
end

puts max_rotation_string(10005)

# 1000 Lights
=begin
You have a bank of switches before you, numbered from 1 to n.
Each switch is connected to exactly one light that is initially off.
You walk down the row of switches and toggle every one of them.
You go back to the beginning, and on this second pass, you toggle switches 2, 4, 6, and so on.
On the third pass, you go back again to the beginning and toggle switches 3, 6, 9, and so on.
You repeat this process and keep going until you have been through n repetitions.

Write a method that takes one argument, the total number of switches,
and returns an Array that identifies which lights are on after n repetitions.

Example with n = 5 lights:

round 1: every light is turned on
round 2: lights 2 and 4 are now off; 1, 3, 5 are on
round 3: lights 2, 3, and 4 are now off; 1 and 5 are on
round 4: lights 2 and 3 are now off; 1, 4, and 5 are on
round 5: lights 2, 3, and 5 are now off; 1 and 4 are on
The result is that 2 lights are left on, lights 1 and 4. The return value is [1, 4].

With 10 lights, 3 lights are left on: lights 1, 4, and 9. The return value is [1, 4, 9].

-> create a hash consisting of keys 1 through n, all values set to FALSE
-> for every element in the hash
  -> if the key is divisible by the number, then negate the boolean value
-> create an empty array
-> loop through the hash
  -> if the value is TRUE, add the key to the array
-> return the array
=end

def lights(n)
  # initialize lights
  lights_hash = {}
  (1..n).each{ |num| lights_hash[num] = false }

  # switch lights
  (1..n).each do |num|
    lights_hash.each_key do |switch|
      if switch % num == 0
        lights_hash[switch] = !lights_hash[switch]
      end
    end
  end

  # create array with indices of illuminated lights
  ans = []
  lights_hash.each_key do |switch|
    if lights_hash[switch] == true
      ans << switch
    end
  end
  ans
end

p lights(5)
p lights(10)

# Further Exploration:
=begin
Do you notice the pattern in our answer? Every light that is on is a perfect square. Why is that?
->  Since all lights start off, in order to be on at the end they have to have an odd number of factors,
    every factor has a pair, except one that is a square root, the same number is repeated.

What are some alternatives for solving this exercise?
What if we used an Array to represent our 1000 lights instead of a Hash, how would that change our code?
->  Couldn't keep track of the status of the light within the array. I would have one array with every possible number,
    then create an empty array of "on" lights. Every time the lights were switched, I would see if the number was in the
    "on" array, if it was I would delete it, if it wasn't I would add it.

We could have a method that replicates the output from the description of this problem
(i.e. "lights 2, 3, and 5 are now off; 1 and 4 are on.") How would we go about writing that code?
->  print the sentence with an interpolation call to a method that creates the list of numbers
->  to create the list of numbers, join all but the last number with ", " and then join the last number with ", and "
=end

# Diamonds!
=begin
Write a method that displays a 4-pointed diamond in an n x n grid,
where n is an odd integer that is supplied as an argument to the method.
You may assume that the argument will always be an odd integer.
->  top and bottom row is always 1
->  middle row is always n
->  if 1, just print *
->  else,
    ->  for top half
      ->  number of stars increases from 1 by 2
      ->  number of spaces decreases from n/2 by 1
    ->  for bottom half
      ->  number of stars decreases from n by 2
      ->  number of spaces increases from 0 by 1
=end
def diamond(n)
num_stars = 1
num_spaces = n/2
  if n == 1
    puts "*"
  else
    until num_spaces == 0
      puts "#{' ' * num_spaces}#{'*' * num_stars}"
      num_stars += 2
      num_spaces -= 1
    end
    until num_spaces > n/2
      puts "#{' ' * num_spaces}#{'*' * num_stars}"
      num_stars -= 2
      num_spaces += 1
    end
  end
end

# Examples:
diamond(1)
=begin
*
=end
diamond(3)
=begin
 *
***
 *
=end
 diamond(9)
=begin
    *
   ***
  *****
 *******
*********
 *******
  *****
   ***
    *
=end

# Further Exploration:
# Try modifying your solution or our solution so it prints only the outline of the diamond:
def print_row(grid_size, distance_from_center)
  number_of_stars = grid_size - 2 * distance_from_center
  if number_of_stars == 1
    side_stars = '*'
  else
    side_stars = '*' + (' ' * (number_of_stars - 2)) + '*'
  end
  puts side_stars.center(grid_size)
end

def inverse_diamond(grid_size)
  max_distance = (grid_size - 1) / 2
  max_distance.downto(0) { |distance| print_row(grid_size, distance) }
  1.upto(max_distance)   { |distance| print_row(grid_size, distance) }
end

inverse_diamond(5)
=begin
  *
 * *
*   *
 * *
  *
=end
inverse_diamond(9)
=begin
    *
   * *
  *   *
 *     *
*       *
 *     *
  *   *
   * *
    *
=end

# Stack Machine Interpretation
=begin
A stack is a list of values that grows and shrinks dynamically.
In ruby, a stack is easily implemented as an Array that just uses the #push and #pop methods.

A stack-and-register programming language is a language that uses a stack of values.
Each operation in the language operates on a register, which can be thought of as the current value.
The register is not part of the stack.
Operations that require two values pop the topmost item from the stack
(that is, the operation removes the most recently pushed value from the stack),
perform the operation using the popped value and the register value, and then store the result back in the register.

Consider a MULT operation in a stack-and-register language.
It multiplies the stack value with the register value, removes the value from the stack,
and then stores the result back in the register. Thus, if we start with a stack of 3 6 4
(where 4 is the topmost item in the stack), and a register value of 7,
then the MULT operation will transform things to 3 6 on the stack (the 4 is removed),
and the result of the multiplication, 28, is left in the register.
If we do another MULT at this point, then the stack is transformed to 3, and the register is left with the value 168.

Write a method that implements a miniature stack-and-register-based programming language that has the following commands:

n Place a value n in the "register". Do not modify the stack.
PUSH Push the register value on to the stack. Leave the value in the register.
ADD Pops a value from the stack and adds it to the register value, storing the result in the register.
SUB Pops a value from the stack and subtracts it from the register value, storing the result in the register.
MULT Pops a value from the stack and multiplies it by the register value, storing the result in the register.
DIV Pops a value from the stack and divides it into the register value, storing the integer result in the register.
MOD Pops a value from the stack and divides it into the register value, storing the integer remainder of the division in the register.
POP Remove the topmost item from the stack and place in register
PRINT Print the register value
All operations are integer operations (which is only important with DIV and MOD).

Programs will be supplied to your language method via a string passed in as an argument.
Your program may assume that all programs are correct programs;
that is, they won't do anything like try to pop a non-existent value from the stack, and they won't contain unknown tokens.

You should initialize the register to 0.

->  convert the string to an array of each word
->  for each word
  ->  check if it's a number
    ->  if yes, set the register to the number
    ->  if no, do the command
=end
def minilang(program_str)
  register = 0
  stack = []
  program_arr = program_str.split(' ')
  program_arr.each do |current_command|
    case current_command
    when /[0-9]/
      register = current_command.to_i
    when 'PUSH'
      stack.push(register)
    when 'ADD'
      return 'Error. Empty Stack.' if stack.empty?
      register += stack.pop
    when 'SUB'
      return 'Error. Empty Stack.' if stack.empty?
      register -= stack.pop
    when 'MULT'
      return 'Error. Empty Stack.' if stack.empty?
      register *= stack.pop
    when 'DIV'
      return 'Error. Empty Stack.' if stack.empty?
      register /= stack.pop
    when 'MOD'
      return 'Error. Empty Stack.' if stack.empty?
      register %= stack.pop
    when 'POP'
      register = stack.pop
    when 'PRINT' then puts register
    else return 'Error. Invalid Token.'
    end
  end
  return nil
end

# Examples:
puts minilang('HEY') == 'Error. Invalid Token.'
# true

puts minilang('5 MULT PRINT') == 'Error. Empty Stack.'
# true

puts minilang('5 PRINT PUSH 3 PRINT ADD PRINT') == nil
# 5
# 3
# 8
# true

minilang('5 PUSH POP PRINT')
# 5

minilang('3 PUSH 4 PUSH 5 PUSH PRINT ADD PRINT POP PRINT ADD PRINT')
# 5
# 10
# 4
# 7

minilang('3 PUSH PUSH 7 DIV MULT PRINT ')
# 6

minilang('4 PUSH PUSH 7 MOD MULT PRINT ')
# 12

minilang('-3 PUSH 5 SUB PRINT')
# 8

minilang('6 PUSH')
# (nothing printed; no PRINT commands)

# Further Exploration:
# Try writing a minilang program to evaluate and print the result of this expression:
# (3 + (4 * 5) - 7) / (5 % 3)
minilang('3 PUSH 5 MOD PUSH 7 PUSH 5 PUSH 4 MULT SUB PUSH 3 ADD DIV PRINT')

# Add some error handling to your method. In particular, have the method detect empty stack conditions,
# and invalid tokens in the program, and report those.
# Ideally, the method should return an error message if an error occurs, and nil if the program runs successfully.

# Word to Digit
=begin
Write a method that takes a sentence string as input, and returns the same string with any sequence of the words
'zero', 'one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine' converted to a string of digits.
=end
DIGITS = {'zero' => '0', 'one' => '1', 'two' => '2', 'three' => '3', 'four' => '4',
          'five' => '5', 'six' => '6', 'seven' => '7', 'eight' => '8', 'nine' => '9'}
def word_to_digit(str)
  str.gsub!(/zero|one|two|three|four|five|six|seven|eight|nine/, DIGITS)
end

# LS solution using a variable in the regex pattern:
def word_to_digit_LS(words)
  DIGITS.keys.each do |word|
    words.gsub!(/\b#{word}\b/, DIGITS[word])
  end
  words
end

puts word_to_digit('Please call me at five five five one two three four. Thanks.') == 'Please call me at 5 5 5 1 2 3 4. Thanks.'

# Further Exploration

# There are many ways to solve this problem and different varieties of it.
# Suppose, for instance, that we also want to replace uppercase and capitalized words.
def word_to_digit2(words)
  DIGITS.keys.each do |word|
    words.gsub!(/\b#{word}\b/i, DIGITS[word])
  end
  words
end
puts word_to_digit2('Please call me at Five five Five one two Three four. Thanks.') == 'Please call me at 5 5 5 1 2 3 4. Thanks.'

# Can you change your solution so that the spaces between consecutive numbers are removed?
# Suppose the string already contains two or more space separated numbers (not words);
# can you leave those spaces alone, while removing any spaces between numbers that you create?
=begin
def word_to_digit3(words)
  DIGITS.keys.each do |word|
    words.gsub!(/\b#{word}\b/i, DIGITS[word])
  end
  words.gsub!(/(\d) (\d)/, '\1\2')
end

puts word_to_digit3('Please call me at five five five one two three four. Thanks.')# == 'Please call me at 5551234. Thanks.'
# Please call me at 55 51 23 4. Thanks.

# What about dealing with phone numbers?
# Is there any easy way to format the result to account for phone numbers?
# For our purposes, assume that any 10 digit number is a phone number,
# and that the proper format should be "(123) 456-7890".
def word_to_digit4(words)
  DIGITS.keys.each do |word|
    words.gsub!(/\b#{word}\b/i, DIGITS[word])
  end
  words.gsub!(/(\d)(\d)(\d)(\d)(\d)(\d)(\d)(\d)(\d)(\d)/, '(\1\2\3) \4\5\6-\7\8\9\10')
end

puts word_to_digit3('Please call me at five five five one two three four. Thanks.')
=end

# Fibonacci Numbers (Recursion)
=begin
The Fibonacci series is a sequence of numbers starting with 1 and 1 where each
number is the sum of the two previous numbers: the 3rd Fibonacci number is 1 + 1 = 2,
the 4th is 1 + 2 = 3, the 5th is 2 + 3 = 5, and so on. In mathematical terms:
F(1) = 1
F(2) = 1
F(n) = F(n - 1) + F(n - 2) where n > 2
Sequences like this translate naturally as "recursive" methods.
A recursive method is one in which the method calls itself. For example:
def sum(n)
  return 1 if n == 1
  n + sum(n - 1)
end
sum is a recursive method that computes the sum of all integers between 1 and n.

Recursive methods have three primary qualities:
1. They call themselves at least once.
2. They have a condition that stops the recursion (n == 1 above).
3. They use the result returned by themselves.

Write a recursive method that computes the nth Fibonacci number, where nth is an argument to the method.
=end
def fibonacci(n)
  return 1 if n == 1 || n == 2
  fibonacci(n - 1) + fibonacci(n - 2)
end

puts fibonacci(1) == 1
puts fibonacci(2) == 1
puts fibonacci(3) == 2
puts fibonacci(4) == 3
puts fibonacci(5) == 5
puts fibonacci(12) == 144
puts fibonacci(20) == 6765

# Fibonacci Numbers (Procedural)
=begin
In the previous exercise, we developed a recursive solution to calculating the nth Fibonacci number.
In a language that is not optimized for recursion, some (not all) recursive methods can be extremely
slow and require massive quantities of memory and/or stack space.

Ruby does a reasonably good job of handling recursion, but it isn't designed for heavy recursion;
as a result, the Fibonacci solution is only useful up to about fibonacci(40).
With higher values of nth, the recursive solution is impractical.
(Our tail recursive solution did much better, but even that failed at around fibonacci(8200).)

Fortunately, every recursive method can be rewritten as a non-recursive (procedural) method.

Rewrite your recursive fibonacci method so that it computes its results without recursion.
=end
def fibonacci_proc(nth)
  s1 = 1
  s2 = 1
  sum = 0
  return 1 if nth <= 2
  (nth - 2).times do |_num|
    sum = s1 + s2
    s1 = s2
    s2 = sum
  end
  sum
end

puts fibonacci_proc(20) == 6765
puts fibonacci_proc(100) == 354224848179261915075
# puts fibonacci_proc(100_001) # => 4202692702.....8285979669707537501
# LS Solution:
=begin
def fibonacci(nth)
  first, last = [1, 1]
  3.upto(nth) do
    first, last = [last, first + last]
  end

  last
end
=end

# Fibonacci Numbers (Last Digit)
=begin
In the previous exercise, we developed a procedural method for computing the value of the nth Fibonacci numbers.
This method was really fast, computing the 20899 digit 100,001st Fibonacci sequence almost instantly.

In this exercise, you are going to compute a method that returns the last digit of the nth Fibonacci number.
-> the digits are a fibinacci_last of the last two digits
=end
def fibonacci_last(nth)
  first, last = [1, 1]
  3.upto(nth) do
    first, last = [last % 10, (first + last) % 10]
  end

  last % 10
end

puts fibonacci_last(15)        # -> 0  (the 15th Fibonacci number is 610)
puts fibonacci_last(20)        # -> 5 (the 20th Fibonacci number is 6765)
puts fibonacci_last(100)       # -> 5 (the 100th Fibonacci number is 354224848179261915075)
puts fibonacci_last(100_001)   # -> 1 (this is a 20899 digit number)
puts fibonacci_last(1_000_007) # -> 3 (this is a 208989 digit number)
puts fibonacci_last(123456789) # -> 4 -> got this but it took ~ 3 seconds

# Further Exploration:
# After a while, even this method starts to take too long to compute results.
# Can you provide a solution to this problem that will work no matter how big the number?
# You should be able to return results almost instantly.
# For example, the 123,456,789,987,745th Fibonacci number ends in 5.
