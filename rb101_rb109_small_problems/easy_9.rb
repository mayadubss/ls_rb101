# RB101-RB109 Small Problems Easy 9

# Welcome Stranger
=begin
Create a method that takes 2 arguments, an array and a hash.
The array will contain 2 or more elements that, when combined with adjoining spaces,
will produce a person's name. The hash will contain two keys, :title and :occupation,
and the appropriate values. Your method should return a greeting that uses the person's full name,
and mentions the person's title and occupation.
=end
def greetings(name_array, bio_hash)
  full_name = name_array.join(' ')
  title = bio_hash[:title]
  occupation = bio_hash[:occupation]
  puts "Hello, #{full_name}! Nice to have a #{title} #{occupation} around."
end

greetings(['John', 'Q', 'Doe'], { title: 'Master', occupation: 'Plumber' })
# => Hello, John Q Doe! Nice to have a Master Plumber around.

# Double Doubles
=begin
A double number is a number with an even number of digits whose left-side digits are
exactly the same as its right-side digits. For example, 44, 3333, 103103, 7676 are all double numbers.
444, 334433, and 107 are not.
Write a method that returns 2 times the number provided as an argument,
unless the argument is a double number; double numbers should be returned as-is.
=end
def double_number?(num)
  num_str = num.to_s
  if num_str.length.even?
    half_length = num_str.length / 2
    first_half = num_str[0, half_length]
    second_half = num_str[half_length, half_length]
    true if first_half == second_half
  else
    false
  end
end

def twice(num)
  double_number?(num) ? num : num * 2
end

puts twice(37) == 74
puts twice(44) == 44
puts twice(334433) == 668866
puts twice(444) == 888
puts twice(107) == 214
puts twice(103103) == 103103
puts twice(3333) == 3333
puts twice(7676) == 7676
puts twice(123_456_789_123_456_789) == 123_456_789_123_456_789
puts twice(5) == 10

# Always Return Negative
=begin
Write a method that takes a number as an argument. If the argument is a positive number,
return the negative of that number. If the number is 0 or negative, return the original number.
=end
def negative(num)
  num <= 0 ? num : -num
end

puts negative(5) == -5
puts negative(-3) == -3
puts negative(0) == 0      # There's no such thing as -0 in ruby

# Counting Up
=begin
Write a method that takes an integer argument, and returns an Array of all integers,
in sequence, between 1 and the argument.
You may assume that the argument will always be a valid integer that is greater than 0.
=end
def sequence1(num)
  arr = []
  num.times {|i| arr << i + 1 }
  arr
end

puts sequence1(5) == [1, 2, 3, 4, 5]
puts sequence1(3) == [1, 2, 3]
puts sequence1(1) == [1]

# Uppercase Check
=begin
Write a method that takes a string argument, and returns true if all of the alphabetic
characters inside the string are uppercase, false otherwise. Characters that are not alphabetic should be ignored.
- just needs to not have any lowercase letters
=end
def uppercase?(string)
  !string.match?(/[a-z]/)
end

puts uppercase?('t') == false
puts uppercase?('T') == true
puts uppercase?('Four Score') == false
puts uppercase?('FOUR SCORE') == true
puts uppercase?('4SCORE!') == true
puts uppercase?('') == true

# How long are you?
=begin
Write a method that takes a string as an argument, and returns an Array that contains every word from the string,
to which you have appended a space and the word length.
You may assume that words in the string are separated by exactly one space,
and that any substring of non-space characters is a word.
- map to return an array with each element converted
- map needs an array as input, so split the string first
=end
def word_lengths(str)
  str.split.map do |word|
    "#{word} #{word.length}"
  end
end

puts word_lengths("cow sheep chicken") == ["cow 3", "sheep 5", "chicken 7"]

puts word_lengths("baseball hot dogs and apple pie") ==
  ["baseball 8", "hot 3", "dogs 4", "and 3", "apple 5", "pie 3"]

puts word_lengths("It ain't easy, is it?") == ["It 2", "ain't 5", "easy, 5", "is 2", "it? 3"]

puts word_lengths("Supercalifragilisticexpialidocious") ==
  ["Supercalifragilisticexpialidocious 34"]

puts word_lengths("") == []

# Name Swapping
=begin
Write a method that takes a first name, a space, and a last name passed as a single String argument,
and returns a string that contains the last name, a comma, a space, and the first name.
=end
def swap_name(full_name)
  first_name = full_name.split[0]
  last_name = full_name.split[1]
  "#{last_name}, #{first_name}"
end

puts swap_name('Joe Roberts') == 'Roberts, Joe'
# LS solution uses Array#reverse and then joins the array

# Sequence Count
=begin
Create a method that takes two integers as arguments. The first argument is a count,
and the second is the first number of a sequence that your method will create.
The method should return an Array that contains the same number of elements as the count argument,
while the values of each element will be multiples of the starting number.
You may assume that the count argument will always have a value of 0 or greater,
while the starting number can be any integer value. If the count is 0, an empty list should be returned.
=end
def sequence2(count, start)
  result = []
  count.times do |i|
    result << start * (i + 1)
  end
  result
end

puts sequence2(5, 1) == [1, 2, 3, 4, 5]
puts sequence2(4, -7) == [-7, -14, -21, -28]
puts sequence2(3, 0) == [0, 0, 0]
puts sequence2(0, 1000000) == []

# Grade book
=begin
Write a method that determines the mean (average) of the three scores passed to it,
and returns the letter value associated with that grade.
Numerical Score Letter	Grade
90 <= score <= 100	'A'
80 <= score < 90	'B'
70 <= score < 80	'C'
60 <= score < 70	'D'
0 <= score < 60	'F'
Tested values are all between 0 and 100. There is no need to check for negative values or values greater than 100.
- going to calculate float average and round to the nearest whole integer
=end
def get_grade(score1, score2, score3)
  scoring = {A: (90..100).to_a,
            B: (80...90).to_a,
            C: (70...80).to_a,
            D: (60...70).to_a,
            F: (0...60).to_a}
  average = (score1 + score2 + score3) / 3
  grade = ''
  scoring.each do |letter, range|
    grade = letter.to_s if range.include?(average)
  end
  grade
end

puts get_grade(95, 90, 93) == "A"
puts get_grade(50, 50, 95) == "D"

# Grocery List
=begin
Write a method which takes a grocery list (array) of fruits with quantities
and converts it into an array of the correct number of each fruit.
=end
def buy_fruit(list_arr)
  final_list = []
  list_arr.each do |item|
    item[1].times { |count| final_list << item[0] }
  end
  final_list
end

puts buy_fruit([["apples", 3], ["orange", 1], ["bananas", 2]]) ==
  ["apples", "apples", "apples", "orange", "bananas","bananas"]

# Group Anagrams
=begin
Given the array, write a program that prints out groups of words that are anagrams.
Anagrams are words that have the same exact letters in them but in a different order.
Your output should look something like this:
["demo", "dome", "mode"]
["neon", "none"]
#(etc)
- assuming there can't be multiple of one of the letters, has to be exact number of each letter
- using a hash to collect the words, then print the hash values
- keys will be arrays of the characters sorted
  - I want to go through the array, for every word
    - create an array of the characters in the word sorted
    - check if the array is a key in the hash
      - if it is, add the word to that value array
      - if not, add the word to a new key
- print the values of the hash
=end
words =  ['demo', 'none', 'tied', 'evil', 'dome', 'mode', 'live',
          'fowl', 'veil', 'wolf', 'diet', 'vile', 'edit', 'tide',
          'flow', 'neon']
def anagrams(array_of_words)
  hash = {}
  array_of_words.each do |word|
    sorted_word = word.chars.sort
    if hash.has_key?(sorted_word)
      hash[sorted_word] << word
    else
      hash[sorted_word] = [word]
    end
  end
  hash.each_value{ |value| p value }
end

anagrams(words)


