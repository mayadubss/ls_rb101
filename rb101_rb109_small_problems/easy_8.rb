# RB101-RB109 Small Problems Easy 8

# Sum of Sums
=begin
Write a method that takes an Array of numbers and then returns the sum of the sums of each leading
subsequence for that Array. You may assume that the Array always contains at least one number.
=end

def sum_of_sums(arr)
  total = 0
  arr.each_index do |index|
    total += arr[0..index].sum
  end
  total
end

puts sum_of_sums([3, 5, 2]) == (3) + (3 + 5) + (3 + 5 + 2) # -> (21)
puts sum_of_sums([1, 5, 7, 3]) == (1) + (1 + 5) + (1 + 5 + 7) + (1 + 5 + 7 + 3) # -> (36)
puts sum_of_sums([4]) == 4
puts sum_of_sums([1, 2, 3, 4, 5]) == 35

# Madlibs
=begin
Create a simple mad-lib program that prompts for a noun, a verb, an adverb,
and an adjective and injects those into a story that you create.
Example:
Enter a noun: dog
Enter a verb: walk
Enter an adjective: blue
Enter an adverb: quickly
=> Do you walk your blue dog quickly? That's hilarious!
=end

puts "Enter a noun:"
noun = gets.chomp
puts "Enter a verb:"
verb = gets.chomp
puts "Enter an adjective:"
adj = gets.chomp
puts "Enter an adverb:"
adverb = gets.chomp

mad_lib = {noun: nil, verb: nil, adjective: nil, adverb: nil}
mad_lib.each do |part_of_speech, _|
  puts "Enter a #{part_of_speech.to_s}:"
  mad_lib[part_of_speech] = gets.chomp
end
puts "Do you #{mad_lib[:verb]} your #{mad_lib[:adjective]} #{mad_lib[:noun]} #{mad_lib[:adverb]}?"
# This is more concise but writes "a adjective" and "a adverb"

# Leading Substrings
=begin
Write a method that returns a list of all substrings of a string that start at the beginning of the original string.
The return value should be arranged in order from shortest to longest substring.
=end

def leading_substrings(string)
  result = []
  string.size.times do |x|
    result << string[0..x]
  end
  result
end

puts leading_substrings('abc') == ['a', 'ab', 'abc']
puts leading_substrings('a') == ['a']
puts leading_substrings('xyzzy') == ['x', 'xy', 'xyz', 'xyzz', 'xyzzy']

# All Substrings
=begin
Write a method that returns a list of all substrings of a string.
The returned list should be ordered by where in the string the substring begins. 
his means that all substrings that start at position 0 should come first,
then all substrings that start at position 1, and so on.
Since multiple substrings will occur at each position,
the substrings at a given position should be returned in order from shortest to longest.
You may (and should) use the leading_substrings method you wrote in the previous exercise:
=end

def substrings(string)
  result = []
  string.size.times do |x|
    substring = string[x..string.size - 1]
    result.concat(leading_substrings(substring))
  end
  result
end

puts substrings('abcde') == [
  'a', 'ab', 'abc', 'abcd', 'abcde',
  'b', 'bc', 'bcd', 'bcde',
  'c', 'cd', 'cde',
  'd', 'de',
  'e'
]

# Palindromic Substrings
=begin
Write a method that returns a list of all substrings of a string that are palindromic.
You may (and should) use the substrings method you wrote in the previous exercise.
Palindromes are case-sensitive in this exercise. Mom is not a palindrome.
Palindrome must me two or more characters!
- call substrings on the string to get an array of all possible strings
- iterate through the array
- delete any substrings that are non palindromes
=end

def palindromes(string)
  palindromes = []
  all_substrings = substrings(string)
  all_substrings.each do |substring|
    if substring == substring.reverse && substring.length > 1
      palindromes << substring
    end
  end
  palindromes
end

p palindromes('abcd') == []
p palindromes('madam') == ['madam', 'ada']
p palindromes('hello-madam-did-madam-goodbye') == [
  'll', '-madam-', '-madam-did-madam-', 'madam', 'madam-did-madam', 'ada',
  'adam-did-mada', 'dam-did-mad', 'am-did-ma', 'm-did-m', '-did-', 'did',
  '-madam-', 'madam', 'ada', 'oo'
]
p palindromes('knitting cassettes') == [
  'nittin', 'itti', 'tt', 'ss', 'settes', 'ette', 'tt'
]

# Further Exploration: Can you modify this method (and/or its predecessors)
# to ignore non-alphanumeric characters and case?
# => I think this would just be deleting the elements with non_alphaneumerics in them before checking for palindromes

# fizzbuzz
=begin
Write a method that takes two arguments: the first is the starting number,
and the second is the ending number. Print out all numbers between the two numbers,
except if a number is divisible by 3, print "Fizz", if a number is divisible by 5,
print "Buzz", and finally if a number is divisible by 3 and 5, print "FizzBuzz".
=end
def fizzbuzz(first, last)
  result = []
  (first..last).each do |num|
    a = num % 3 == 0 ? true : false
    b = num % 5 == 0 ? true : false
    case
    when a && b then result << "FizzBuzz"
    when a then result << "Fizz"
    when b then result << "Buzz"
    else result << num
    end
  end
  puts result.join(', ')
end

fizzbuzz(1, 15) # -> 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz

# Double Char (Part 1)
=begin
Write a method that takes a string, and returns a new string in which every character is doubled.
- create an empty string
- loop through each character in the given string
- add each character twice to the empty string
=end
def repeater(string)
  doubled_str = ''
  string.chars.each do |char|
    doubled_str << char << char
  end
  doubled_str
end

puts repeater('Hello') == "HHeelllloo"
puts repeater("Good job!") == "GGoooodd  jjoobb!!"
puts repeater('') == ''

# Double Char (Part 2)
=begin
Write a method that takes a string, and returns a new string in which every consonant character is doubled.
Vowels (a,e,i,o,u), digits, punctuation, and whitespace should not be doubled.
- similar to double char but check if char is non-vowel letter
=end
def double_consonants(string)
  doubled_str = ''
  string.chars.each do |char|
    if char.match?(/[b-df-hj-np-tv-z]/i)
      doubled_str << char << char
    else
      doubled_str << char
    end
  end
  doubled_str
end
# LS solution added char the first time, then just checked the condition for the second add

puts double_consonants('String') == "SSttrrinngg"
puts double_consonants("Hello-World!") == "HHellllo-WWorrlldd!"
puts double_consonants("July 4th") == "JJullyy 4tthh"
puts double_consonants('') == ""

# Reverse the Digits in a Number
=begin
Write a method that takes a positive integer as an argument and returns that number with its digits reversed.
Don't worry about arguments with leading zeros.
=end
def reversed_number(num)
  num.to_s.reverse.to_i
end

puts reversed_number(12345) == 54321
puts reversed_number(12213) == 31221
puts reversed_number(456) == 654
puts reversed_number(12000) == 21 # No leading zeros in return value!
puts reversed_number(12003) == 30021
puts reversed_number(1) == 1

# Get the Middle Character
=begin
Write a method that takes a non-empty string argument, and returns the middle character or characters of the argument.
If the argument has an odd length, you should return exactly one character.
If the argument has an even length, you should return exactly two characters.
- for odd length, length/2 will be the middle index
- for even length, length/2 will be the second of the two characters
  - subtract one to get the first character, and make the length of the splice 2
=end
def center_of(string)
  if string.length.odd?
    string[string.length / 2]
  else
    string[(string.length / 2) - 1, 2]
  end
end

puts center_of('I love ruby') == 'e'
puts center_of('Launch School') == ' '
puts center_of('Launch') == 'un'
puts center_of('Launchschool') == 'hs'
puts center_of('x') == 'x'


