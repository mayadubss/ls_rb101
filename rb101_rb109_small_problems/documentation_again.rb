# Documentation Again

# Class and Instance Methods
# Locate the ruby documentation for methods File::path and File#path. How are they different?
# Both are in class File, under methods there is ::path and #path
# #path is called as Ex_File.path("ex_path") and returns ex_path as a string
  # This is an instance method - it is called on an object, Ex_File
# ::path is called as File.new("ex_path").path and returns ex_path as a string
  # This is a class method, called on the class, File

# Optional Arguments Redux
# What does the following code print?
require 'date'

puts Date.civil # "-4712-01-01"
puts Date.civil(2016) # "2016-01-01"
puts Date.civil(2016, 5) # "2016-05-01"
puts Date.civil(2016, 5, 13) # "2016-05-13"

# Default Arguments in the Middle
# Use the ruby documentation to determine what this code will print.
def my_method(a, b = 2, c = 3, d) # b and c are given with default values
  p [a, b, c, d]
end

my_method(4, 5, 6) # [4, 5, 3, 6]

# Mandatory Blocks
# How would you search this Array to find the first element whose value exceeds 8?
# Use the Array#bsearch method
a = [1, 4, 8, 11, 15, 19]
puts a.bsearch {|x| x > 8}

# Multiple Signatures
# What do each of these puts statements output?
a = %w(a b c d e)
# puts a.fetch(7) # nil - nope this is actually an error
puts a.fetch(7, 'beats me') # 'beats me'
puts a.fetch(7) { |index| index**2 } # 49

# Keyword Arguments
# What does this code print?
5.step(to: 10, by: 3) { |value| puts value } # 5 8

# Parent Class
# Edit the code to only print the methods defined or overridden by the String Class
# Current code prints methods defined in String and parent Object class which inherits from BasicObject class and Kernel module
s = 'abc'
puts s.public_methods(false).inspect # added (false) per Object class documentation to only return methods in the receiver

# Included Modules
# Find the documentation for the #min method and change the above code to print the two smallest values in the Array.
a = [5, 9, 3, 11]
puts a.min(2) # added (2) per min documentation which will return up to 2 elements in a new array

# Down the Rabbit Hole
# Find the documentation for YAML::load_file
# This ended up being a method in the module Psych which is described as a YAML parser and emitter