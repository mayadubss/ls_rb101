# Small Problems: Easy 3

def prompt(words)
  puts "=> #{words}"
end

# Searching 101
=begin
Write a program that solicits 6 numbers from the user,
then prints a message that describes whether or not the 6th number
appears amongst the first 5 numbers.
- Ask the user for 5 numbers, one at a time
- As the numbers are inputted, append them to an array
- Ask the user for the last number
- Check if the last number is included in the array
- Print

count = {1 => "1st", 2 => "2nd", 3 => "3rd", 4 => "4th", 5 => "5th"}
numbers = []
for x in (1..5) do 
  prompt("Enter the #{count[x]} number:")
  numbers << gets.chomp.to_i
end

prompt("Enter the last number:")
check_number = gets.chomp.to_i

if numbers.include?(check_number)
  puts "The number #{check_number} appears in #{numbers}."
else
  puts "The number #{check_number} does not appear in #{numbers}."
end
=end
# Arithmetic Integer
=begin
Write a program that prompts the user for two positive integers,
and then prints the results of the following operations on those two numbers:
addition, subtraction, product, quotient, remainder, and power.
Do not worry about validating the input.
- Ask for the first and second number, assign them to variables
- Print the operation being performed and the answer

prompt("Enter the first number:")
first = gets.chomp.to_i
prompt("Enter the second number:")
second = gets.chomp.to_i

prompt("#{first} + #{second} = #{first + second}")
prompt("#{first} - #{second} = #{first - second}")
prompt("#{first} * #{second} = #{first * second}")
prompt("#{first} / #{second} = #{first / second}")
prompt("#{first} % #{second} = #{first % second}")
prompt("#{first} ** #{second} = #{first ** second}")
=end
# Counting the Number of Characters
=begin
Write a program that will ask a user for an input of a word or multiple words
and give back the number of characters. Spaces should not be counted as a character.
- Ask for the input of a word or multiply words
- Save the input to a variable
- loop through the string for the length of the string
- add to a counter if the character is not a space
- Return the length of the string

prompt("Please write a word or multiple words:")
words = gets.chomp
count = 0
for x in (0...words.length) do
  count += 1 if words[x] != " "
end
prompt("There are #{count} characters in '#{words}'.")
# LS solution uses String#delete method to delete spaces then .length
# LS solution uses \"#{words}\" -> the \ tells ruby to ignore the next character
=end

# Multiplying Two Numbers
=begin
Create a method that takes two arguments, multiplies them together, and returns the result.
def multiply(x, y)
  x * y
end
puts multiply(5, 3) == 15
=end
# Squaring an Argument
=begin
Using the multiply method from the "Multiplying Two Numbers" problem,
write a method that computes the square of its argument
(the square is the result of multiplying a number by itself).

def square(x)
  multiply(x, x)
end
puts square(5) == 25
# further exploration
def power(x, n)
  answer = 1
  n.times {answer = multiply(x, answer) }
  answer
end
puts power(2, 4) == 16
=end
# Exclusive Or
=begin
Write a method for xor => only true if one argument is true and one is false
- this is the overlap of where && is false and || is true

def xor?(condition1, condition2)
  !!(!(condition1 && condition2) && (condition1 || condition2))
end
# wrapping in !!() means that the method will return false instead of nil

puts xor?(5.even?, 4.even?) == true
puts xor?(5.odd?, 4.odd?) == true
puts xor?(5.odd?, 4.even?) == false
puts xor?(5.even?, 4.odd?) == false
=end
# Odd Lists
=begin
Write a method that returns an Array that contains every other element of an Array
that is passed in as an argument. The values in the returned list should be those
values that are in the 1st, 3rd, 5th, and so on elements of the argument Array.
- Define a method with one parameter
- define a new array
- loop through the array passed as an argument
- check if the index is odd
- if it is odd, add that element to the new array
- return the new array

def oddities(array)
  result = []
  array.each_index {|index| result << array[index] if index.even?}
  result
end

# Further exploration: write the method in 2 new ways
def oddities2(array)
  result = []
  array.each {|element| result << element if array.index(element).even?}
  result
end

def oddities3(array)
  count = 0
  result = []
  while count < array.length
    result << array[count] if count.even?
    count += 1
  end
  result
end

puts oddities([2, 3, 4, 5, 6]) == [2, 4, 6]
puts oddities2([1, 2, 3, 4, 5, 6]) == [1, 3, 5]
puts oddities2(['abc', 'def']) == ['abc']
puts oddities3([123]) == [123]
puts oddities3([]) == []
=end
# Palindromic Strings (Part 1)
=begin
Write a method that returns true if the string passed as an argument is a palindrome,
false otherwise. A palindrome reads the same forward and backward.
For this exercise, case matters as does punctuation and spaces.
- define a method that takes a string
- check string is equal to the String#reverse
=end

def palindrome?(string)
  string == string.reverse
end

puts palindrome?('madam') == true
puts palindrome?('Madam') == false          # (case matters)
puts palindrome?("madam i'm adam") == false # (all characters matter)
puts palindrome?('356653') == true
puts palindrome?([1, 2, 3, 2, 1]) == true

# Palindromic Strings (Part 2)
=begin
Write another method that returns true if the string passed as an argument is a palindrome,
false otherwise. This time, however, your method should be case-insensitive,
'and it should ignore all non-alphanumeric characters.
If you wish, you may simplify things by calling the palindrome? method you wrote in the previous exercise.
- create an array of the alphabet and numbers
- call downcase on the string
- turn string into an array of each character
- loop through the array and keep only characters that are included in the alphanumeric array (mutate)
- call palindrome? on the new array
=end

def real_palindrome?(string)
  alphanumerics = "abcdefghijklmnopqrstuvwxyz1234567890".split('')
  alphanumeric_array = string.downcase.chars.select {|element| alphanumerics.include?(element)}
  palindrome?(alphanumeric_array)
end
#LS solution uses String#delete which will delete any characters passed as an argument
#OR you can pass ^ following by characters to keep -> it will delete all except those chracters

puts real_palindrome?('madam') == true
puts real_palindrome?('Madam') == true           # (case does not matter)
puts real_palindrome?("Madam, I'm Adam") == true # (only alphanumerics matter)
puts real_palindrome?('356653') == true
puts real_palindrome?('356a653') == true
puts real_palindrome?('123ab321') == false

# Palindromic Numbers
=begin
Write a method that returns true if its integer argument is palindromic, false otherwise.
A palindromic number reads the same forwards and backwards.
=end
def palindromic_number?(num)
  palindrome?(num.to_s)
end

#further exploration: if the number starts with one or more 0's will it still work?
# This doesn't work because the number is being converted into binary or some other number type

puts palindromic_number?(34543) == true
puts palindromic_number?(1232100) == false
puts palindromic_number?(22) == true
puts palindromic_number?(5) == true
