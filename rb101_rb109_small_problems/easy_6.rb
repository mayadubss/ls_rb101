# RB101-RB109 Small Problems - Easy 6

# Cute Angles
=begin
Write a method that takes a floating point number that represents an angle between 0 and 360 degrees
and returns a String that represents that angle in degrees, minutes and seconds.
You should use a degree symbol (°) to represent degrees, a single quote (') to represent minutes,
and a double quote (") to represent seconds. A degree has 60 minutes, while a minute has 60 seconds.
- the number before the decimal (if there is one) is the degrees
- multiply what's after the decimal by 60
  - this answer before the decimal (if there is one) is the minutes
- multiply what's after the decimal by 60
  - this answer before the decimal (if there is one) is the seconds
=end

DEGREE = "\xC2\xB0"
def two_digits(integer)
  if integer < 10
    integer = "0#{integer}"
  else
    integer
  end
end

def dms(angle)
  angle = angle % 360
  degrees = angle.truncate
  minutes_float = (angle - degrees) * 60
  minutes = minutes_float.truncate
  seconds_float = (minutes_float - minutes) * 60
  seconds = seconds_float.truncate
  "#{degrees}#{DEGREE}#{two_digits(minutes)}\'#{two_digits(seconds)}\""
  # format(%(#{degrees}#{DEGREE}%02d'%02d"), minutes, seconds) -> THIS IS FROM THE LS SOLUTION USING FORMAT
end

puts dms(30)# == %(30°00'00")
puts dms(76.73)# == %(76°43'48")
puts dms(254.6)# == %(254°36'00")
puts dms(93.034773)# == %(93°02'05")
puts dms(0)# == %(0°00'00")
puts dms(360)# == %(360°00'00") || dms(360) == %(0°00'00")

# Further exploration:
puts dms(400)# == %(40°00'00")
puts dms(-40)# == %(320°00'00")
puts dms(-420)# == %(300°00'00")

# Delete Vowels
=begin
Write a method that takes an array of strings, and returns an array of the same string values,
except with the vowels (a, e, i, o, u) removed.
=end

def remove_vowels(array)
  array.each{ |string| string.delete! "aeiouAEIOU" } # LS solution used Array#map vice Array#each
end

p remove_vowels(%w(abcdefghijklmnopqrstuvwxyz)) == %w(bcdfghjklmnpqrstvwxyz)
p remove_vowels(%w(green YELLOW black white)) == %w(grn YLLW blck wht)
p remove_vowels(%w(ABC AEIOU XYZ)) == ['BC', '', 'XYZ']

# Fibonacci Number Location by Length
=begin
Write a method that calculates and returns the index of the first Fibonacci number that has the
number of digits specified as an argument. (The first Fibonacci number has index 1.)
- starting at 1 and 1, iterates through the fibonacci sequence until the length of the number equals the parameter
=end

def find_fibonacci_index_by_length(number_of_digits)
  fibonacci = [1, 1]
  until fibonacci.last.digits.length == number_of_digits do
    fibonacci << fibonacci[-1] + fibonacci[-2]
  end
  fibonacci.length
end

puts find_fibonacci_index_by_length(2) == 7          # 1 1 2 3 5 8 13
puts find_fibonacci_index_by_length(3) == 12         # 1 1 2 3 5 8 13 21 34 55 89 144
puts find_fibonacci_index_by_length(10) == 45
puts find_fibonacci_index_by_length(100) == 476
puts find_fibonacci_index_by_length(1000) == 4782
#puts find_fibonacci_index_by_length(10000) == 47847 # this last one takes forever with this method
# LS says we will go through recursive methods later so I'll just leave it as-is

# Reversed Arrays (Part 1)
=begin
Write a method that takes an Array as an argument, and reverses its elements in place;
that is, mutate the Array passed into this method. The return value should be the same Array object.
You may not use Array#reverse or Array#reverse!.
=end

def reverse!(array)
  count1 = 0
  count2 = array.length - 1
  until count1 >= count2 do
    array[count1], array[count2] = array[count2], array[count1]
    count1 += 1
    count2 -= 1
  end
  array
end

list = [1,2,3,4]
result = reverse!(list)
puts result == [4, 3, 2, 1] # true
puts list == [4, 3, 2, 1] # true
puts list.object_id == result.object_id # true

list = %w(a b e d c)
puts reverse!(list) == ["c", "d", "e", "b", "a"] # true
puts list == ["c", "d", "e", "b", "a"] # true

list = ['abc']
puts reverse!(list) == ["abc"] # true
puts list == ["abc"] # true

list = []
puts reverse!(list) == [] # true
puts list == [] # true

# Reversed Arrays (Part 2)
=begin
Write a method that takes an Array, and returns a new Array with the elements of the original list
in reverse order. Do not modify the original list.
=end

def reverse(array)
  new_array = []
  array.each { |element| new_array.unshift(element) }
  new_array
end
# LS solution used Array#reverse_each which just iterates through the elements of array in reverse order

puts reverse([1,2,3,4]) == [4,3,2,1]          # => true
puts reverse(%w(a b e d c)) == %w(c d e b a)  # => true
puts reverse(['abc']) == ['abc']              # => true
puts reverse([]) == []                        # => true

list = [1, 3, 2]                      # => [1, 3, 2]
new_list = reverse(list)              # => [2, 3, 1]
puts list.object_id != new_list.object_id  # => true
puts list == [1, 3, 2]                     # => true
puts new_list == [2, 3, 1]                 # => true

# Further Exploration: using Enumerable#inject

def reverse2(array)
  array.inject([]) {|arr, element| arr.unshift(element) }
end

puts reverse2([1,2,3,4]) == [4,3,2,1]          # => true
puts reverse2(%w(a b e d c)) == %w(c d e b a)  # => true
puts reverse2(['abc']) == ['abc']              # => true
puts reverse2([]) == []                        # => true

list = [1, 3, 2]                      # => [1, 3, 2]
new_list = reverse(list)              # => [2, 3, 1]
puts list.object_id != new_list.object_id  # => true
puts list == [1, 3, 2]                     # => true
puts new_list == [2, 3, 1]                 # => true

# Combining Arrays
=begin
Write a method that takes two Arrays as arguments, and returns an Array that contains all
of the values from the argument Arrays. There should be no duplication of values in the returned Array,
even if there are duplicates in the original Arrays.
- Assumption: return a new object
=end

def merge(array1, array2)
  new_array = []
  array1.each { |element| new_array << element}
  array2.each { |element| new_array << element}
  new_array.uniq!
end
# LS Solution used Array#| method which is a union method. Like an OR to create a new array.

puts merge([1, 3, 5], [3, 6, 9]) == [1, 3, 5, 6, 9]

# Halvsies
=begin
Write a method that takes an Array as an argument, and returns two Arrays (as a pair of nested Arrays)
that contain the first half and second half of the original Array, respectively.
If the original array contains an odd number of elements, the middle element should be placed
in thefirst half Array.
- if the array length is odd the length/2 goes in the first half, if even it goes in the second half
=end

def halvsies(array)
  new_array = []
  array.length.odd? ? new_array = [array.slice(0..array.length/2), array.slice((array.length/2) + 1..array.length - 1)] :
                      new_array = [array.slice(0..(array.length/2) - 1), array.slice(array.length/2..array.length - 1)]
end

p halvsies([1, 2, 3, 4]) == [[1, 2], [3, 4]]
p halvsies([1, 5, 2, 4, 3]) == [[1, 5, 2], [4, 3]]
p halvsies([5]) == [[5], []]
p halvsies([]) == [[], []]

# Further Exploration: LS solution found the middle using length/2.0.ceil where Float#ceil rounds any decimal up to the
# nearest whole number. They divided by 2.0 so the answer would be a float if the length was odd, say 3/2.0 -> 1.5

# Find the Duplicate
=begin
Given an unordered array and the information that exactly one value in the array occurs twice
(every other value occurs exactly once), how would you determine which value occurs twice?
Write a method that will find and return the duplicate value that is known to be in the array.
- need to loop through the array
  - for every number in the array
  - compare the number to all of the numbers after it
=end

def find_dup(array)
  seen_numbers = []
  array.each do |number|
    return number if seen_numbers.include?(number)
    seen_numbers << number
  end
end

p find_dup([1, 5, 3, 1]) == 1
p find_dup([18,  9, 36, 96, 31, 19, 54, 75, 42, 15,
          38, 25, 97, 92, 46, 69, 91, 59, 53, 27,
          14, 61, 90, 81,  8, 63, 95, 99, 30, 65,
          78, 76, 48, 16, 93, 77, 52, 49, 37, 29,
          89, 10, 84,  1, 47, 68, 12, 33, 86, 60,
          41, 44, 83, 35, 94, 73, 98,  3, 64, 82,
          55, 79, 80, 21, 39, 72, 13, 50,  6, 70,
          85, 87, 51, 17, 66, 20, 28, 26,  2, 22,
          40, 23, 71, 62, 73, 32, 43, 24,  4, 56,
          7,  34, 57, 74, 45, 11, 88, 67,  5, 58]) == 73

# Does My List Include This?
=begin
Write a method named include? that takes an Array and a search value as arguments.
This method should return true if the search value is in the array, false if it is not.
You may not use the Array#include? method in your solution.
=end

def include?(array, search_value)
  array.each do |value|
    return true if search_value == value
  end
  false
end

#Further exploration:
def include2?(array, search_value)
  !!array.find_index(search_value)
end

puts include2?([1,2,3,4,5], 3) == true
puts include2?([1,2,3,4,5], 6) == false
puts include2?([], 3) == false
puts include2?([nil], nil) == true
puts include2?([], nil) == false

# Right Triangles
=begin
Write a method that takes a positive integer, n, as an argument, and displays a right triangle
whose sides each have n stars. The hypotenuse of the triangle (the diagonal side in the images below)
should have one end at the lower-left of the triangle, and the other end at the upper-right.
=end
def triangle(length)
  star_count = 1
  while star_count <= length
    puts " " * (length - star_count) + "*" * star_count
    star_count += 1
  end
end

# Further exploration: Try modifying your solution so it prints the triangle upside down from its current orientation.
def flip_triangle(length)
  star_count = length
  while star_count > 0
    puts " " * (length - star_count) + "*" * star_count
    star_count -= 1
  end
end

# Further exploration: Modify again so that you can display the triangle with the right angle at any corner of the grid.
def any_triangle(length, corner)
  star_count = 0
  case corner
  when 'tl'
    star_count = length
    while star_count > 0
      puts "*" * star_count + " " * (length - star_count)
      star_count -= 1
    end
  when 'tr'
    star_count = length
    while star_count > 0
      puts " " * (length - star_count) + "*" * star_count
      star_count -= 1
    end
  when 'bl'
    star_count = 1
    while star_count <= length
      puts "*" * star_count + " " * (length - star_count)
      star_count += 1
    end
  when 'br'
    star_count = 1
    while star_count <= length
      puts " " * (length - star_count) + "*" * star_count
      star_count += 1
    end
  else
    puts "right angle options are: tl, tr, bl, or br"
  end
end

any_triangle(4, 'tr')
any_triangle(4, 'tl')
any_triangle(4, 'br')
any_triangle(4, 'bl')
any_triangle(4, 'cx')
