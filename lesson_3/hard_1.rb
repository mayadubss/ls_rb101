# Lesson 3: Practice Problems - Hard 1

# Question 1
# What do you expect to happen when the greeting variable is referenced in the last line of the code below?

if false
  greeting = "hello world"
end

puts greeting

# => there will be an error because greeting is never initialized since the if statement evaluates to false --> Wrong
# => right answer: when you initialize a local variable within an if block,
# => even if that if block doesn’t get executed, the local variable is initialized to nil.

# Question 2
# What is the result of the last line of code below
greetings = { a: 'hi' }
informal_greeting = greetings[:a]
informal_greeting << ' there'

puts informal_greeting  #  => "hi there"
puts greetings # => { a: 'hi there' } --> based on medium_2 problems, << should mutate the string, not create a new object

# Question 3
# What will be printed by each of these code groups?

# A:
def mess_with_vars1(one, two, three)
  one = two
  two = three
  three = one
end

one = "one"
two = "two"
three = "three"

mess_with_vars1(one, two, three)

puts "one is: #{one}" # => one is: one
puts "two is: #{two}" # => two is: two
puts "three is: #{three}" # => three is: three
# the variables will stay the same because the method created new variables that happen to have the same names

# B:
def mess_with_vars2(one, two, three)
  one = "two"
  two = "three"
  three = "one"
end

one = "one"
two = "two"
three = "three"

mess_with_vars2(one, two, three)

puts "one is: #{one}" # => one is: one
puts "two is: #{two}" # => two is: two
puts "three is: #{three}" # => three is: three
# Same as A, the method creates new variables within its scope that can not be accessed outside the method

# C:
def mess_with_vars3(one, two, three)
  one.gsub!("one","two")
  two.gsub!("two","three")
  three.gsub!("three","one")
end

one = "one"
two = "two"
three = "three"

mess_with_vars3(one, two, three)

puts "one is: #{one}" # => one is: two
puts "two is: #{two}" # => two is: three
puts "three is: #{three}" # => three is: one
# This time gsub! mutates the object itself, so it doesn't matter that the variables are new.

# Question 4
=begin
Ben was tasked to write a simple ruby method to determine if an input string is an IP address
representing dot-separated numbers. e.g. "10.4.5.11". He is not familiar with regular expressions.
Alyssa supplied Ben with a method called is_an_ip_number? that determines if a string is a numeric
string between 0 and 255 as required for IP numbers and asked Ben to use it.
=end
def is_an_ip_number?(word)
  word.to_i >= 0 && word.to_i < 256 ? true : false
end

def dot_separated_ip_address?(input_string)
  dot_separated_words = input_string.split(".")
  return false unless dot_separated_words.size == 4
  while dot_separated_words.size > 0 do
    word = dot_separated_words.pop
    return false unless is_an_ip_number?(word)
  end
  true
end

puts dot_separated_ip_address?("10.4.5.11")
=begin
Alyssa reviewed Ben's code and says "It's a good start, but you missed a few things.
You're not returning a false condition, and you're not handling the case that there are
more or fewer than 4 components to the IP address (e.g. "4.5.5" or "1.2.3.4.5" should be invalid)."

Help Ben fix his code.
=end


