# Small Problems - Easy 2
def prompt(words)
  puts "=> #{words}"
end

# How old is Teddy?
# Build a program that randomly generates and prints Teddy's age.
# To get the age, you should generate a random number between 20 and 200.
puts "Teddy is #{rand(20..200)} years old!"
# further exploration: Modify this program to ask for a name, and then print the age for that person.
# For an extra challenge, use "Teddy" as the name if no name is entered.
def say_age(name, age)
  if name.empty?
    puts "Teddy is #{age} years old!"
  else
    puts "#{name} is #{age} years old!"
  end
end
prompt('What is your name?')
name = gets.chomp
age = rand(0..100)
say_age(name, age)

# How big is the room?
# Build a program that asks a user for the length and width of a room in meters
# and then displays the area of the room in both square meters and square feet.
# Note: 1 square meter == 10.7639 square feet
SQMETER_TO_SQFT = 10.7639
prompt('What is the length of your room in meters?')
length = gets.chomp.to_f
prompt('What is the width of your room in meters?')
width = gets.chomp.to_f
area_meters = length * width
area_sqft = area_meters * SQMETER_TO_SQFT
prompt("The area of your room is #{area_meters} square meters and #{area_sqft} square feet")
# Further exploration
# Modify this program to ask for the input measurements in feet,
# and display the results in square feet, square inches, and square centimeters.
SQFT_TO_SQIN = 144
SQFT_TO_SQCM = 929.03
prompt('What is the length of the room in feet?')
length_feet = gets.chomp.to_f
prompt('What is the width of the room in feet?')
width_feet = gets.chomp.to_f
area2_sqft = length_feet * width_feet
area2_sqin = (area2_sqft * SQFT_TO_SQIN).round(2)
area2_sqcm = (area2_sqft * SQFT_TO_SQCM).round(2)
prompt("The area of your room is:
          #{area2_sqft} square feet,
          #{area2_sqin} square inches,
          #{area2_sqcm} square centimeters.")

# Tip Calculator
# Create a simple tip calculator. The program should prompt for a bill amount and a tip rate.
# The program must compute the tip and then display both the tip and the total amount of the bill.
prompt('What is the bill?')
bill_subtotal = gets.chomp.to_f
prompt('What is the tip percentage?')
tip_percentage = gets.chomp.to_f
tip = (bill_subtotal * (tip_percentage / 100)).round(2)
tip_money = format("%.2f", tip)
total = (bill_subtotal + tip).round(2)
total_money = format("%.2f", total)
prompt("Your tip is $#{tip_money}.")
prompt("Your total bill is $#{total_money}.")
# Further exploration: this solution prints one decimal instead of, ex: 50.00. Fix it
# Added tip_money and total_money to turn tip and total into normal money format.

# When Will I Retire?
# Build a program that displays when the user will retire and how many years she has to work till retirement.
CURRENTYEAR = 2021
prompt('What is your age?')
age = gets.chomp.to_i
prompt('At what age would you like to retire?')
retire_age = gets.chomp.to_i
years_to_retire = retire_age - age
retire_year = CURRENTYEAR + years_to_retire
prompt("It's #{CURRENTYEAR}, you will retire in #{retire_year}.")
prompt("You only have #{years_to_retire} years of work left!")

# Greeting a User
# Write a program that will ask for user's name. The program will then greet the user.
# If the user writes "name!" then the computer yells back to the user.
prompt('What is your name?')
name = gets.chomp
if name.include?("!")
  name.chop!
  puts "HELLO #{name.upcase}. WHY ARE WE YELLING?"
else
  puts "Hello #{name}."
end

# Odd Numbers
# Print all odd numbers from 1 to 99, inclusive, to the console, with each number on a separate line.
count = 0
while count < 100
  puts count if count.odd?
  count += 1
end
# Further exploration: try again in a different way
nums = Array(1..99)
nums.each { |x| puts x if x % 2 == 1 }

# Even Numbers
# Print all even numbers from 1 to 99, inclusive, to the console, with each number on a separate line.
count = 1
while count < 100
  puts count if count.even?
  count += 1
end

# Sum or Product of Consecutive Integers
# Write a program that asks the user to enter an integer greater than 0,
# then asks if the user wants to determine the sum or product of all numbers between 1 and the entered integer.
def sum(integer)
  range = Array(1..integer)
  total = 0
  until range.empty?
    total += range.pop
  end
  total
end

def product(integer)
  range = Array(1..integer)
  total = 1
  until range.empty?
    total *= range.pop
  end
  total
end

# practicing launch school solution
def ls_sum(integer)
  total = 0
  1.upto(integer) { |x| total += x }
  total
end

def ls_product(integer)
  total = 1
  1.upto(integer) { |x| total *= x }
  total
end

# further exploration: using Enumerable#inject
def bonus_sum(integer)
  (1..integer).inject { |sum, n| sum + n }
end

def bonus_product(integer)
  (1..integer).inject { |product, n| product * n }
end

prompt('Please enter an integer greater than 0:')
integer = gets.chomp.to_i
prompt("Enter 's' to compute the sum, 'p' to compute the product.")
operation = gets.chomp

case operation
when 's'
  prompt("The sum of the integers between 1 and #{integer} is #{bonus_sum(integer)}.")
when 'p'
  prompt("The product of the integers between 1 and #{integer} is #{bonus_product(integer)}.")
end

# String Assignment
# What does this code print out?
name = 'Bob'
save_name = name
name = 'Alice'
puts name, save_name
# name is Alice and save_name is still Bob -> yes
# what does this code print out?
name = 'Bob'
save_name = name
name.upcase!
puts name, save_name
# BOB, BOB because the object name is pointing to was mutated

# Mutation
# What will the code print out?
array1 = %w(Moe Larry Curly Shemp Harpo Chico Groucho Zeppo)
array2 = []
array1.each { |value| array2 << value }
# appends each element of array2 to array1, doesn't change array2
# elements of array2 now point to the same objects as the equivalent index in array1
array1.each { |value| value.upcase! if value.start_with?('C', 'S') }
# mutates objects in array1, array2 elements that point to those objects will also change
puts array2
# a2 => ["Moe", "Larry", "CURLY", "SHEMP", "Harpo", "CHICO", "Groucho", "Zeppo"]
# got this all right!
