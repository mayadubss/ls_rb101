# Small Problems Easy 5

# ASCII String Value
=begin
Write a method that determines and returns the ASCII string value of a string that is
passed in as an argument. The ASCII string value is the sum of the ASCII values of every
character in the string. (You may use String#ord to determine the ASCII value of a character.)
- String#ord -> returns Integer ordinal of a one-character string
- Split the string into an array of characters
- Define the ASCII total as 0
- Loop through the array
  - For each element, use String#ord to get the ASCII value and add it to the ASCII total
=end

def ascii_value(string)
  chars = string.chars
  ascii_total = 0
  chars.each{ |element| ascii_total += element.ord}
  ascii_total
end

puts ascii_value('Four score') == 984
puts ascii_value('Launch School') == 1251
puts ascii_value('a') == 97
puts ascii_value('') == 0
# LS solution uses String#each_char rather than doing #chars and then #each
# Further exploration: Integer#chr is the opposite of String#ord
# if you do "string".ord.chr then only the first character is returned not the whole string

# After Midnight (Part 1)
=begin
The time of day can be represented as the number of minutes before or after midnight.
If the number of minutes is positive, the time is after midnight.
If the number of minutes is negative, the time is before midnight.
Write a method that takes a time using this minute-based format and returns the time
of day in 24 hour format (hh:mm). Your method should work with any integer input.
You may not use ruby's Date and Time classes.
- the given number divided by 60 is the number of hours after 24 and the
  remainder is the number of minutes past that hour
- need to account for the number being more than 24 hours (60 * 24 = 1440)
- need to account for single digits that should still have a leading 0.
- check if the absolute value of the number is less than 1440
  - If it is, divide it by 60. The answer is the number of hours from 0 in the negative or positive direction.
    The remainder is the number of minutes, always positive.
  - If it isn't, divide the number by 1440 until the absolute value of the remainder is less than 1440.
    Then do the first step.
=end

def time_as_string(time)
  string_time = time < 10 ? "0#{time.to_s}" : "#{time.to_s}"
end

def time_of_day(integer)
  loop do
    break if integer.abs < 1440
    integer = integer.divmod(1440)[1]
  end
  hours, minutes = integer.divmod(60)
  hours += 24 if hours < 0
  "#{time_as_string(hours)}:#{time_as_string(minutes)}"
end

puts time_of_day(0) == "00:00"
puts time_of_day(-3) == "23:57"
puts time_of_day(35) == "00:35"
puts time_of_day(-1437) == "00:03"
puts time_of_day(3000) == "02:00"
puts time_of_day(800) == "13:20"
puts time_of_day(-4231) == "01:29"
# LS solution defines CONSTANTS so the numbers don't seem random
# LS solution adds 1440 until the number is between 0-1439 so there are no negatives
# LS solution uses Kernel#format to create the string, for mine this would be:
  # format('%02d:%02d', hours, minutes)

=begin
# Further exploration:
1: It's possible to write a single calculation with % that performs the entire normalization
   operation in one line of code. Give it a try, but don't spend too much time on it.
   - If the divisor is negative, the result of modulo will be nagative

2: How would you approach this problem if you were allowed to use ruby's Date and Time classes?

3: How would you approach this problem if you were allowed to use ruby's Date and Time classes
   and wanted to consider the day of week in your calculation? (Assume that delta_minutes is
   the number of minutes before or after midnight between Saturday and Sunday; in such a method,
   a delta_minutes value of -4231 would need to produce a return value of Thursday 01:29.)
=end

# After Midnight (Part 2)
=begin
Write two methods that each take a time of day in 24 hour format,
and return the number of minutes before and after midnight, respectively.
Both methods should return a value in the range 0..1439.
- convert the time from string to integer for hour and minutes
- multiply hours by minutes per hour
- add to minutes (after midnight)
- subtract that total from 1440(before midnight)
=end

MINUTES_PER_HOUR = 60
MINUTES_PER_DAY = 1440

def after_midnight(time_string)
  hours_to_minutes = time_string[0..1].to_i * MINUTES_PER_HOUR
  minutes = time_string[3..4].to_i
  (hours_to_minutes + minutes) % MINUTES_PER_DAY
end

def before_midnight(time_string)
  (MINUTES_PER_DAY - after_midnight(time_string)) % MINUTES_PER_DAY
end

puts after_midnight('00:00') == 0
puts before_midnight('00:00') == 0
puts after_midnight('12:34') == 754
puts before_midnight('12:34') == 686
puts after_midnight('24:00') == 0
puts before_midnight('24:00') == 0
# Further exploration: how would these methods change if you could use Date and Time classes?

# Letter Swap
=begin
Given a string of words separated by spaces, write a method that takes this string of words
and returns a string in which the first and last letters of every word are swapped.
You may assume that every word contains at least one letter,
and that the string will always contain at least one word.
You may also assume that each string contains nothing but words and spaces
- split the string into an array of each word
- iterate through the array
  - split each word into an array of characters
    - assign the first and last elements to variables, in a mutating way
    - add the variables back to the array in opposite placement
- turn the array of the new words back into a string where they are separated by spaces
=end

def swap(sentence)
  array_of_words = sentence.split(" ")
  array_of_words.map! do |word|
    #array_of_chars = word.chars
    #first = array_of_chars.shift
    #last = array_of_chars.pop
    #array_of_chars.unshift(last).push(first).join
    word[0], word[-1] = word[-1], word[0]
    word
  end
  array_of_words.join(" ")
end

puts swap('Oh what a wonderful day it is') == 'hO thaw a londerfuw yad ti si'
puts swap('Abcde') == 'ebcdA'
puts swap('a') == 'a'
# LS solution shows Ruby allows: a, b = b, a
# This will assign a temporary array as [b, a] to assign a and b to each other simultaneously
# Also, characters in a word can be accessed like arrays, word[0] for first, word [-1] for last
# Further exploration: the swap first and last character method LS used could not be called by
# passing the characters that need to be swapped because it would return the two characters rather
# than the full altered word

# Clean up the words
=begin
Given a string that consists of some words (all lowercased)
and an assortment of non-alphabetic characters,
write a method that returns that string with all of the non-alphabetic characters replaced by spaces.
If one or more non-alphabetic characters occur in a row,
you should only have one space in the result (the result should never have consecutive spaces).
- create a constant for the alphabet
- create an empty answer array
- for every character in the string
  - if the character is in the alphabet, add it to the answer array
  - if the character is not in the alphabet,
    - if the last character in the answer is not a space, add a space, else do nothing
=end

ALPHABET = %w(a b c d e f g h i j k l m n o p q r s t u v w x y z)

def cleanup(string)
  final_string = ''
  string.each_char do |char|
    if ALPHABET.include?(char)
      final_string << char
    else
      final_string << ' ' if final_string[final_string.length - 1] != ' '
    end
  end
  final_string
end

puts cleanup("---what's my +*& line?") == ' what s my line '
# A helpful method for this would have been String#squeeze which will turn all sequential and duplicate
# characters or spaces into one of that character or space
# NOTE: A good clarification for an interviewer would be if you are supposed to return an altered version
#       of the string or a new string object

# Letter Counter (Part 1)
=begin
Write a method that takes a string with one or more space separated words
and returns a hash that shows the number of words of different sizes.
Words consist of any string of characters that do not include a space.
- create an empty hash
- split the string into an array of the space separated words
- for each element in the array
  - see if the hash has a key matching the length of the word
    - if yes, increment that key's value
    - if no, add the length as a new key with value 1
- return the hash
=end

def word_sizes(sentence)
  word_count = Hash.new{0} # use the default value form of initializing the hash
                           # so any non existing key will default to a value of 0 instead of nil
  array_of_words = sentence.split(' ')
  array_of_words.each do |word|
    word_count[word.length] += 1
  end
  word_count
end

puts word_sizes('Four score and seven.') == { 3 => 1, 4 => 1, 5 => 1, 6 => 1 }
puts word_sizes('Hey diddle diddle, the cat and the fiddle!') == { 3 => 5, 6 => 1, 7 => 2 }
puts word_sizes("What's up doc?") == { 6 => 1, 2 => 1, 4 => 1 }
puts word_sizes('') == {}

# Letter Counter (Part 2)
=begin
Modify the word_sizes method from the previous exercise to exclude non-letters when determining word size.
For instance, the length of "it's" is 3, not 4.
- same as word_sizes, but delete characters that aren't in the alphabet
=end

def word_sizes2(sentence)
  word_count = Hash.new{0}
  array_of_words = sentence.split(' ')
  array_of_words.each do |word|
    word.each_char {|char| word.delete!(char) if !ALPHABET.include?(char.downcase)}
    # other option here: word.delete!('^A-Za-z') where ^ means delete what is not included in the alphabet
    word_count[word.length] += 1
  end
  word_count
end

puts word_sizes2('Four score and seven.') == { 3 => 1, 4 => 1, 5 => 2 }
puts word_sizes2('Hey diddle diddle, the cat and the fiddle!') == { 3 => 5, 6 => 3 }
puts word_sizes2("What's up doc?") == { 5 => 1, 2 => 1, 3 => 1 }
puts word_sizes2('') == {}

# Alphabetical Numbers
=begin
Write a method that takes an Array of Integers between 0 and 19,
and returns an Array of those Integers sorted based on the English words for each number:
zero, one, two, three, four, five, six, seven, eight, nine, ten, eleven, twelve, thirteen,
fourteen, fifteen, sixteen, seventeen, eighteen, nineteen
- define an array of the english words at their correct index
- map the array to the element in the conversion array at that index
- sort the array
=end

def alphabetic_number_sort(array)
  integer_to_english = %w(zero one two three four five six seven eight nine ten eleven twelve
                          thirteen fourteen fifteen sixteen seventeen eighteen nineteen)
  array.map!{|integer| integer_to_english[integer]}.sort!
  array.map!{|integer| integer_to_english.index(integer)}
end

puts alphabetic_number_sort((0..19).to_a) == [
  8, 18, 11, 15, 5, 4, 14, 9, 19, 1, 7, 17,
  6, 16, 10, 13, 3, 12, 2, 0
]
# LS solution uses Enumerable#sort_by
# Further exploration:
def alphabetic_number_sort2(array)
  integer_to_english = %w(zero one two three four five six seven eight nine ten eleven twelve
                          thirteen fourteen fifteen sixteen seventeen eighteen nineteen)
  array.sort {|number1, number2| integer_to_english[number1] <=> integer_to_english[number2]}
end

puts alphabetic_number_sort2((0..19).to_a) == [
  8, 18, 11, 15, 5, 4, 14, 9, 19, 1, 7, 17,
  6, 16, 10, 13, 3, 12, 2, 0
]

# ddaaiillyy ddoouubbllee
=begin
Write a method that takes a string argument and returns a new string that contains
the value of the original string with all consecutive duplicate characters collapsed
into a single character. You may not use String#squeeze or String#squeeze!
- define an empty answer array
- split the string into an array of characters
- loop through the array
  - save the character to the new array unless the last character of the new array matches it
- return the array joined to a string
=end

def crunch(string)
  crunched_array = []
  string.each_char do |char|
    crunched_array << char unless crunched_array.last == char
  end
  crunched_array.join
end

puts crunch('ddaaiillyy ddoouubbllee') == 'daily double'
puts crunch('4444abcabccba') == '4abcabcba'
puts crunch('ggggggggggggggg') == 'g'
puts crunch('a') == 'a'
puts crunch('') == ''

# Bannerizer
=begin
Write a method that will take a short line of text, and print it within a box.
- use format
- create the main line
- create one variable for the top and bottom borders
  - '++' then fill with enough -'s to match the width of the main line
- create one variable for the side border sections above and below the text line
  - '||' then enough spaces to match the width of the main line
- print each line in the right order
=end
def print_in_box(string)
  main_line = "| #{string} |"
  top_bottom_line = "+#{"".center(main_line.length - 2, '-')}+" # instead of center could do "-" * main_line.length
  above_below_main_line = "|#{"".center(main_line.length - 2, ' ')}|"
  p top_bottom_line
  p above_below_main_line
  p main_line
  p above_below_main_line
  p top_bottom_line
end

print_in_box('To boldly go where no one has gone before.')
=begin
+--------------------------------------------+
|                                            |
| To boldly go where no one has gone before. |
|                                            |
+--------------------------------------------+
=end
=begin
Further exploration:
Modify this method so it will truncate the message if it will be too wide to fit
inside a standard terminal window (80 columns, including the sides of the box).
=end
MAX_WINDOW_WIDTH = 80
MAX_STRING_LENGTH = 80 - 4

def truncate_print_in_box(string)
  string = string[0, MAX_STRING_LENGTH]
  main_line = "| #{string} |"
  top_bottom_line = "+#{"".center(main_line.length - 2, '-')}+" # instead of center could do "-" * main_line.length
  above_below_main_line = "|#{"".center(main_line.length - 2, ' ')}|"
  p top_bottom_line
  p above_below_main_line
  p main_line
  p above_below_main_line
  p top_bottom_line
end
truncate_print_in_box("I'm going to write the longest sentence in the world, I'm not sure how long 80 characters is or when this will get cut off.")
=begin
Further exploration:
For a real challenge, try word wrapping very long messages so they appear on
multiple lines, but still within a box.
=end

# Spin Me Around In Cirlces
=begin
You are given a method named spin_me that takes a string as an argument and returns
a string that contains the same words, but with each word's characters reversed.
Given the method's implementation, will the returned string be the same object as
the one passed in as an argument or a different object?
Answer: The returned string will be a new object, as soon as the string is split
within the method, str is pointing to the array of the split string, a new object
=end

def spin_me(str)
  str.split.each do |word|
    word.reverse!
  end.join(" ")
end

spin_me("hello world") # "olleh dlrow"
