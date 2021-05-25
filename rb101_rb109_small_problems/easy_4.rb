# Small Problems: Easy 4

# Short Long Short
=begin
Write a method that takes two strings as arguments, determines the longest of the two strings,
and then returns the result of concatenating the shorter string, the longer string,
and the shorter string once again. You may assume that the strings are of different lengths.
- if the first string is longer than the second string
- return second string, first string, second string
- else return the first string, second string, first string
- there is no option where they are equal lengths
=end

def short_long_short(string1, string2)
  if string1.length > string2.length
    string2 + string1 + string2
  else
    string1 + string2 + string1
  end
end

puts short_long_short('abc', 'defgh') == "abcdefghabc"
puts short_long_short('abcde', 'fgh') == "fghabcdefgh"
puts short_long_short('', 'xyz') == "xyz"

# What Century is That?
=begin
Write a method that takes a year as input and returns the century.
The return value should be a string that begins with the century number,
and ends with st, nd, rd, or th as appropriate for that number.
- create a hash for the endings, i.e. 1 - st, 2 - nd, 3 - rd, etc.
- save the result of divmod called on the year with the argument 100
- if index 1 is equal to 0, the centery is index 0
- else the century is one plus index 0
- return the century concatinated to the ending associated with the right most digit
=end

def format_century(century) # takes a number as input and returns a string
  suffix = {1 => 'st', 2 => 'nd', 3 => 'rd', 4 => 'th', 5 => 'th',
            6 => 'th', 7 => 'th', 8 => 'th', 9 => 'th', 0 => 'th',
            11 => 'th', 12 => 'th', 13 => 'th'}
  ones_digit = century % 10
  tens_digit = century % 100
  if suffix.has_key?(tens_digit)
    century.to_s + suffix[tens_digit]
  else
    century.to_s + suffix[ones_digit]
  end
end

def century(year)
  century_array = year.divmod(100)
  century = ''
  if century_array[1] == 0
    century = format_century(century_array[0])
  else
    century = format_century(century_array[0] + 1)
  end
end


puts century(2000) == '20th'
puts century(2001) == '21st'
puts century(1965) == '20th'
puts century(256) == '3rd'
puts century(5) == '1st'
puts century(10103) == '102nd'
puts century(1052) == '11th'
puts century(1127) == '12th'
puts century(11201) == '113th'

# Leap Years (Part 1)
=begin
In the modern era under the Gregorian Calendar,
leap years occur in every year that is evenly divisible by 4,
unless the year is also divisible by 100. If the year is evenly divisible by 100,
then it is not a leap year unless the year is evenly divisible by 400.
Assume this rule is good for any year greater than year 0.
Write a method that takes any year greater than 0 as input,
and returns true if the year is a leap year, or false if it is not a leap year.
- divisible by 4?
  - yes: divisible by 100?
    - yes: divisible by 400?
      - yes: leap year
      - no: not a leap year
    - no: leap year
  - no: not leap year
=end

def leap_year?(year)
  a = year % 4 == 0 ? true : false
  b = year % 100 == 0 ? true : false
  c = year % 400 == 0 ? true : false
  (a && !b) || (a && b && c)
end

puts leap_year?(2016) == true
puts leap_year?(2015) == false
puts leap_year?(2100) == false
puts leap_year?(2400) == true
puts leap_year?(240000) == true
puts leap_year?(240001) == false
puts leap_year?(2000) == true
puts leap_year?(1900) == false
puts leap_year?(1752) == true
puts leap_year?(1700) == false
puts leap_year?(1) == false
puts leap_year?(100) == false
puts leap_year?(400) == true

# Leap Years (Part 2)
=begin
The British Empire adopted the Gregorian Calendar in 1752, which was a leap year.
Prior to 1752, the Julian Calendar was used. Under the Julian Calendar,
leap years occur in any year that is evenly divisible by 4.
=end

def leap_year2?(year)
  if year > 1752
    leap_year?(year)
  elsif year % 4 == 0
    true
  else
    false
  end
end

puts leap_year2?(2016) == true
puts leap_year2?(2015) == false
puts leap_year2?(2100) == false
puts leap_year2?(2400) == true
puts leap_year2?(240000) == true
puts leap_year2?(240001) == false
puts leap_year2?(2000) == true
puts leap_year2?(1900) == false
puts leap_year2?(1752) == true
puts leap_year2?(1700) == true
puts leap_year2?(1) == false
puts leap_year2?(100) == true
puts leap_year2?(400) == true

# Multiples of 3 and 5
=begin
Write a method that searches for all multiples of 3 or 5 that lie between 1 and some other number,
and then computes the sum of those multiples. For instance, if the supplied number is 20,
the result should be 98 (3 + 5 + 6 + 9 + 10 + 12 + 15 + 18 + 20).
You may assume that the number passed in is an integer greater than 1.
Note: 15 is a multiple of 3 and 5 but was only counted once
- Create an empty array to collect the multiples
- Count by 3s up to the other number, and add each number to the array
- Count by 5s up to the other number, and add each number to the array
- Delete any duplicate numbers from the array
- Return the sum of all numbers in the array
=end

def multisum(number)
  multiples = []
  count_3s = 3
  count_5s = 5
  while count_3s <= number
    multiples << count_3s
    count_3s += 3
  end
  while count_5s <= number
    multiples << count_5s
    count_5s += 5
  end
  multiples.uniq.sum
end

puts multisum(3) == 3
puts multisum(5) == 8
puts multisum(10) == 33
puts multisum(1000) == 234168

# Further exploration
# Enumerable#inject -> combines all elements of the caller by applying a binary operation
# Can pass a block as the operation
def multisum2(max_value)
  (1..max_value).inject(0) do |sum, number|
    (number % 3 == 0) || (number % 5 == 0) ? sum + number : sum
  end
end

puts multisum2(3) == 3
puts multisum2(5) == 8
puts multisum2(10) == 33
puts multisum2(1000) == 234168

# Running Totals
=begin
Write a method that takes an Array of numbers,
and returns an Array with the same number of elements,
and each element has the running total from the original Array.
- create an empty array
- create a sum variable
- for each element in the array
  - add it to the sum
  - append the sum to the new array
=end

def running_total(array)
  totals = []
  sum = 0
  array.each do |number|
    sum += number
    totals << sum
  end
  totals
end

puts running_total([2, 5, 13]) == [2, 7, 20]
puts running_total([14, 11, 7, 15, 20]) == [14, 25, 32, 47, 67]
puts running_total([3]) == [3]
puts running_total([]) == []
# LS solution: used Array#map to just change each element to the running sum
# array.map {|number| sum += number}
# Further exploration: solve this problem using Enumerable#each_with_object or Enumerable#inject
def running_total2(array)
  sum = 0
  array.each_with_object([]) {|number, a| a << sum += number}
end

puts running_total2([2, 5, 13]) == [2, 7, 20]
puts running_total2([14, 11, 7, 15, 20]) == [14, 25, 32, 47, 67]
puts running_total2([3]) == [3]

# Convert a String to a Number!
=begin
Write a method that takes a String of digits, and returns the appropriate number as an integer.
You may not use String#to_i or Integer().
For now, do not worry about leading + or - signs, nor should you worry about invalid characters;
assume all characters will be numeric.
=end

def string_to_integer(string)
  s_to_i = {'0' => 0, '1' => 1, '2' => 2, '3' => 3, '4' => 4,
            '5' => 5, '6' => 6, '7' => 7, '8' => 8, '9' => 9}
  digits = string.split('')
  digits.map!{|letter| s_to_i[letter]}

  value = 0
  digits.each {|digit| value = 10 * value + digit}
  value
end

puts string_to_integer('4321') == 4321
puts string_to_integer('570') == 570


# Further Exploration: convert a string representing a hex number to its integer equivalent
def hexadecimal_to_integer(string)
  h_to_i = {'0' => 0, '1' => 1, '2' => 2, '3' => 3, '4' => 4,
            '5' => 5, '6' => 6, '7' => 7, '8' => 8, '9' => 9,
            'A' => 10, 'B' => 11, 'C' => 12, 'D' => 13, 'E' => 14, 'F' => 15}
  digits2 = string.split('')
  digits2.map!{|letter| h_to_i[letter.upcase]}
  
  value = 0
  for i in 0...digits2.length do
    value += digits2.pop * (16 ** i)
  end
  value
end
  
puts hexadecimal_to_integer('4D9f') == 19871

# Convert a String to a Signed Number!
=begin
Write a method that takes a String of digits, and returns the appropriate number as an integer.
The String may have a leading + or - sign; if the first character is a +,
your method should return a positive number; if it is a -, your method should return a negative number.
If no sign is given, you should return a positive number.
You may use the string_to_integer method from the previous exercise
=end

def string_to_signed_integer(string)
  if string.start_with?("+")
    string_to_integer(string.delete("+"))
  elsif string.start_with?("-")
    -string_to_integer(string.delete("-"))
  else
    string_to_integer(string)
  end
end

puts string_to_signed_integer('4321') == 4321
puts string_to_signed_integer('-570') == -570
puts string_to_signed_integer('+100') == 100

# LS solution uses case instead of if/else
# Further exploration: In our solution, we call string[1..-1] twice,
# and call string_to_integer three times. This is somewhat repetitive.
# Refactor our solution so it only makes these two calls once each.

def string_to_signed_integer2(string)
  sign = string.start_with?("-") ? -1 : 1
  string.delete!("+-")
  sign * string_to_integer(string)
end

puts string_to_signed_integer2('4321') == 4321
puts string_to_signed_integer2('-570') == -570

# Convert a Number to a String!
=begin
Write a method that takes a positive integer or zero, and converts it to a string representation.
=end

def integer_to_string(number)
  i_to_s = {1 => '1', 2 => '2', 3 => '3', 4 => '4', 5 => '5',
            6 => '6', 7 => '7', 8 => '8', 9 => '9', 0 => '0'}
  string = number == 0 ? '0' : ''
  while number > 0
    string.prepend(i_to_s[number % 10])
    number /= 10
  end
  string
end

puts integer_to_string(4321) == '4321'
puts integer_to_string(0) == '0'
puts integer_to_string(5000) == '5000'

# LS solution used an array constant for the integers, because you start with an integer you can
# just use that to get the string character from the array
# Further exploration: prepend is mutating but doesn't have a !
# find other string methods that are mutating that don't have a !
# String#insert(index, string) mutates
# String#replace(other_str)
# String, Array, and Hash all don't have methods that end with ! without a matching method that doesn't end with !

# Convert a Signed Number to a String!
=begin
Write a method that takes an integer, and converts it to a string representation.
Take a negative or positive number
=end
def signed_integer_to_string(integer)
  string = ''
  if integer < 0
    string = '-' + integer_to_string(-integer)
  elsif integer > 0
    string = '+' + integer_to_string(integer)
  else
    string = '0'
  end
  string
end

puts signed_integer_to_string(4321) == '+4321'
puts signed_integer_to_string(-123) == '-123'
puts signed_integer_to_string(0) == '0'

# Further exploration: refactor the LS solution
def signed_integer_to_string2(number)
  string = number < 0 ? '-' : '+'
  string += integer_to_string(number.abs)
  string.delete!("+") if number == 0
  string
end

puts signed_integer_to_string2(4321) == '+4321'
puts signed_integer_to_string2(-123) == '-123'
puts signed_integer_to_string2(0) == '0'
