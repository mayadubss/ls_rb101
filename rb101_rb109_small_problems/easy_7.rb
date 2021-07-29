# RB101-109 Small Problems: Easy 7

UPPERCASE_LETTERS = ('A'..'Z').to_a
LOWERCASE_LETTERS = ('a'..'z').to_a

# Combine Two Lists
=begin
Write a method that combines two Arrays passed in as arguments, and returns a new Array
that contains all elements from both Array arguments, with the elements taken in alternation.
You may assume that both input Arrays are non-empty, and that they have the same number of elements.
- also assuming it doesn't matter if I alter the original arrays
=end

def interleave(array1, array2)
  final_array = []
  array1.size.times do |index|
    final_array << array1[index]
    final_array << array2[index]
  end
  final_array
end

# Example:
p interleave([1, 2, 3], ['a', 'b', 'c']) == [1, 'a', 2, 'b', 3, 'c']

# Further Exploration: Use Array#zip and one other Array class method to rewrite interleave
def interleave2(array1, array2)
  array1.zip(array2).flatten
end

p interleave2([1, 2, 3], ['a', 'b', 'c']) == [1, 'a', 2, 'b', 3, 'c']

# Lettercase Counter
=begin
Write a method that takes a string, and then returns a hash that contains 3 entries:
one represents the number of characters in the string that are lowercase letters,
one the number of characters that are uppercase letters, and one the number of characters that are neither.
=end

def letter_case_count(string)
  result = {}
  result[:lowercase] = string.scan(/[a-z]/).size
  result[:uppercase] = string.scan(/[A-Z]/).size
  result[:neither] = string.scan(/[^a-zA-Z]/).size
  result
end

# Example:
puts letter_case_count('abCdef 123') == { lowercase: 5, uppercase: 1, neither: 4 }
puts letter_case_count('AbCd +Ef') == { lowercase: 3, uppercase: 3, neither: 2 }
puts letter_case_count('123') == { lowercase: 0, uppercase: 0, neither: 3 }
puts letter_case_count('') == { lowercase: 0, uppercase: 0, neither: 0 }

# Capitalize Words
=begin
Write a method that takes a single String argument and returns a new string that contains
the original value of the argument with the first character of every word capitalized and all other letters lowercase.
You may assume that words are any sequence of non-blank characters.
=end

def word_cap(sentence)
  words = sentence.split(" ")
  words.each{ |word| word.capitalize! }
  words.join(" ")
end

# Example:
puts word_cap('four score and seven') == 'Four Score And Seven'
puts word_cap('the javaScript language') == 'The Javascript Language'
puts word_cap('this is a "quoted" word') == 'This Is A "quoted" Word'

# Further Exploration: come up with two more methods that do not use String#capitalize

def word_cap1(sentence)
  words = sentence.split(" ")
  words.each do |word|
    word[0] = UPPERCASE_LETTERS[LOWERCASE_LETTERS.index(word[0])] if LOWERCASE_LETTERS.include?(word[0])
    for i in (1...word.size)
      word[i] = LOWERCASE_LETTERS[UPPERCASE_LETTERS.index(word[i])] if UPPERCASE_LETTERS.include?(word[i])
    end
  end
  words.join(" ")
end

puts word_cap1('four score and seven') == 'Four Score And Seven'
puts word_cap1('the javaScript language') == 'The Javascript Language'
puts word_cap1('this is a "quoted" word') == 'This Is A "quoted" Word'

# Swap Case
=begin
Write a method that takes a string as an argument and returns a new string in which every
uppercase letter is replaced by its lowercase version, and every lowercase letter by its uppercase version.
All other characters should be unchanged.
You may not use String#swapcase; write your own version of this method.
=end

def swapcase(string)
  for i in (0..string.size)
    if UPPERCASE_LETTERS.include?(string[i])
      string[i] = LOWERCASE_LETTERS[UPPERCASE_LETTERS.index(string[i])]
    elsif LOWERCASE_LETTERS.include?(string[i])
      string[i] = UPPERCASE_LETTERS[LOWERCASE_LETTERS.index(string[i])]
    end
  end
  string
end

# Example:
puts swapcase('CamelCase') == 'cAMELcASE'
puts swapcase('Tonight on XYZ-TV') == 'tONIGHT ON xyz-tv'

# Staggered Caps (Part 1)
=begin
Write a method that takes a String as an argument, and returns a new String that contains
the original value using a staggered capitalization scheme in which every other character is capitalized,
and the remaining characters are lowercase. Characters that are not letters should not be changed,
but count as characters when switching between upper and lowercase.
=end

def staggered_case(string)
  char_count = 1
  staggered_result = string.downcase.chars.each do |char|
    char.upcase! if char_count.odd?
    char_count += 1
  end
  staggered_result.join
end

# Example:
p staggered_case('I Love Launch School!') == 'I LoVe lAuNcH ScHoOl!'
p staggered_case('ALL_CAPS') == 'AlL_CaPs'
p staggered_case('ignore 77 the 444 numbers') == 'IgNoRe 77 ThE 444 NuMbErS'

# Further Exploration: Modify the LS method so the caller can request that the first character be downcased
# rather than upcased. If the first character is downcased, then the second character should be upcased, and so on.
def staggered_case_LS(string, start = 'up')
  result = ''
  case start
  when 'up' then need_upper = true
  when 'down' then need_upper = false
  else puts "Start parameter must be 'up' or 'down'"
  end
  string.chars.each do |char|
    if need_upper
      result += char.upcase
    else
      result += char.downcase
    end
    need_upper = !need_upper
  end
  result
end

p staggered_case_LS('I Love Launch School!', 'up') # => "I LoVe lAuNcH ScHoOl!"
p staggered_case_LS('I Love Launch School!') # => "I LoVe lAuNcH ScHoOl!"
p staggered_case_LS('I Love Launch School!', 'down') # => "i lOvE LaUnCh sChOoL!"
p staggered_case_LS('I Love Launch School!', 'blah') # => Start parameter must be 'up' or 'down'

# Staggered Caps (Part 2)
=begin
Modify the method from the previous exercise so it ignores non-alphabetic characters when determining
whether it should uppercase or lowercase each letter. The non-alphabetic characters should still be
included in the return value; they just don't count when toggling the desired case.
=end

def staggered_case2(string)
  result = ''
  need_upper = true
  string.chars.each do |char|
    if need_upper
      result += char.upcase
    else
      result += char.downcase
    end
    need_upper = !need_upper if char.match(/[a-zA-Z]/)
  end
  result
end

# Example:
puts staggered_case2('I Love Launch School!') == 'I lOvE lAuNcH sChOoL!'
puts staggered_case2('ALL CAPS') == 'AlL cApS'
puts staggered_case2('ignore 77 the 444 numbers') == 'IgNoRe 77 ThE 444 nUmBeRs'

# Further Exploration: Modify this method so the caller can determine whether non-alphabetic characters
# should be counted when determining the upper/lowercase state. That is, you want a method that can perform
# the same actions that this method does, or operates like the previous version.
def staggered_case3(string, count_non_alphebetic = true)
  result = ''
  need_upper = true
  string.chars.each do |char|
    if char =~ /[a-z]/i || count_non_alphebetic
      if need_upper
        result += char.upcase
      else
        result += char.downcase
      end
      need_upper = !need_upper
    else
      result << char
    end
  end
  result
end

puts staggered_case3('I Love Launch School!', true) == 'I LoVe lAuNcH ScHoOl!'
puts staggered_case3('ALL_CAPS') == 'AlL_CaPs'
puts staggered_case3('ignore 77 the 444 numbers', true) == 'IgNoRe 77 ThE 444 NuMbErS'
puts staggered_case3('I Love Launch School!', false) == 'I lOvE lAuNcH sChOoL!'
puts staggered_case3('ALL CAPS', false) == 'AlL cApS'
puts staggered_case3('ignore 77 the 444 numbers',false) == 'IgNoRe 77 ThE 444 nUmBeRs'

# Multiplicative Average
=begin
Write a method that takes an Array of integers as input, multiplies all the numbers together,
divides the result by the number of entries in the Array, and then prints the result rounded
to 3 decimal places. Assume the array is non-empty.
=end

def show_multiplicative_average(array)
  result = 1.0
  for i in (0...array.size)
    result *= array[i]
  end
  average = result/array.size
  puts "The result is #{format("%.3f", average)}"
end

# Examples:
show_multiplicative_average([3, 5])                # => The result is 7.500
show_multiplicative_average([6])                   # => The result is 6.000
show_multiplicative_average([2, 5, 7, 11, 13, 17]) # => The result is 28361.667

# Further Exploration: if you don't use a float to begin, your 3 trailing decimal places will always be 0s
# Multiply Lists
=begin
Write a method that takes two Array arguments in which each Array contains a list of numbers,
and returns a new Array that contains the product of each pair of numbers from the arguments
that have the same index. You may assume that the arguments contain the same number of elements.
=end

def multiply_list(array1, array2)
  result = []
  array1.each_index { |i| result << array1[i] * array2[i] }
  result
end

# Example:
puts multiply_list([3, 5, 7], [9, 10, 11]) == [27, 50, 77]

# Further Exploration: write a one-line solution using Array#zip (not including def and end lines)
def multiply_list2(array1, array2)
  result = array1.zip(array2).map{ |pair| pair[0] * pair[1] }
end

puts multiply_list2([3, 5, 7], [9, 10, 11]) == [27, 50, 77]

# Multiply All Pairs
=begin
Write a method that takes two Array arguments in which each Array contains a list of numbers,
and returns a new Array that contains the product of every pair of numbers that can be formed
between the elements of the two Arrays. The results should be sorted by increasing value.
You may assume that neither argument is an empty Array.
=end

def multiply_all_pairs(array1, array2)
  result = []
  for i in (0...array1.size)
    array2.each{|num| result << array1[i] * num}
  end
  result.sort!
end

# Example:
puts multiply_all_pairs([2, 4], [4, 3, 1, 2]) == [2, 4, 4, 6, 8, 8, 12, 16]

# The End Is Near But Not Here
=begin
Write a method that returns the next to last word in the String passed to it as an argument.
Words are any sequence of non-blank characters.
You may assume that the input String will always contain at least two words.
=end
def penultimate(string)
  string.split(" ")[-2]
end

# Examples:
puts penultimate('last word') == 'last'
puts penultimate('Launch School is great!') == 'is'

# Further exploration: Suppose we need a method that retrieves the middle word of a phrase/sentence.
# What edge cases need to be considered? How would you handle those edge cases without ignoring them?
# Write a method that returns the middle word of a phrase or sentence. It should handle all of the edge cases you thought of.
# => If string has even number of words, say that.
# => If string has one word just return that word
# => If string is empty, say that.

def penultimate2(string)
  words = string.split(" ")
  case
  when words.size == 0 then "String is empty."
  when words.size % 2 == 0 then "String has no middle word."
  else words[words.size/2]
  end
end

puts penultimate2('') # => "String is empty."
puts penultimate2('last word') # => "String has no middle word."
puts penultimate2('Launch School is great!') # => "String has no middle word."
puts penultimate2('Maya Dubrow is the best!') # => "is"
