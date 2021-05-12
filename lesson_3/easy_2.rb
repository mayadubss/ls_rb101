# Practice Problems: Easy 2

# 1
# In this hash of people and their age, see if "Spot" is present
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }
puts ages.has_key?("Spot") # could be just #key?
puts ages.include?("Spot")
puts ages.member?("Spot")

# 2
# Starting with this string:
munsters_description = "The Munsters are creepy in a good way."
# Convert the string in the following ways (code will be executed on original munsters_description above):
version1 = munsters_description.swapcase
version2 = munsters_description.capitalize
version3 = munsters_description.downcase
version4 = munsters_description.upcase

puts version1 == "tHE mUNSTERS ARE CREEPY IN A GOOD WAY."
puts version2 == "The munsters are creepy in a good way."
puts version3 == "the munsters are creepy in a good way."
puts version4 == "THE MUNSTERS ARE CREEPY IN A GOOD WAY."

# 3
# Add ages for Marilyn and Spot to the existing ages hash from problem 1
additional_ages = { "Marilyn" => 22, "Spot" => 237 }
ages.merge!(additional_ages)
puts ages

# 4
# See if the name "Dino" appears in the string below:
advice = "Few things in life are as important as house training your pet dinosaur."
puts advice.include?("Dino")
# LS solution: advice.match?("Dino")

# 5
# Show an easier way to write this array:
flintstones = ["Fred", "Barney", "Wilma", "Betty", "BamBam", "Pebbles"]
flintstones_easy = %w(Fred Barney Wilma Betty BamBam Pebbles)
p flintstones_easy

# 6
# How can we add the family pet "Dino" to our usual array (flintstones_easy):
flintstones_easy << "Dino"
p flintstones_easy

# 7
# We could have used either Array#concat or Array#push to add Dino to the family in problem 6
# How can we add multiple items to our array? (Dino and Hoppy)
flintstones_easy.pop # just to get back to before adding Dino
p flintstones_easy.concat(%w(Dino Hoppy))
# Other LS solution: flintstones.push("Dino").push("Hoppy")  -> push returns the array so we can chain

# 8
# Review the String#slice! documentation, and use that method to make the return value "Few things in life are as important as ".
# But leave the advice variable as "house training your pet dinosaur.".
advice = "Few things in life are as important as house training your pet dinosaur."
advice.slice!("Few things in life are as important as ")
puts advice

# LS Solution:
# advice.slice!(0, advice.index('house'))  # => "Few things in life are as important as "
# p advice # => "house training your pet dinosaur."

# 9
# Write a one-liner to count the number of lower-case 't' characters in the following string:
statement = "The Flintstones Rock!"
puts statement.count 't'


# 10
# Back in the stone age (before CSS) we used spaces to align things on the screen.
# If we had a table of Flintstone family members that was forty characters in width,
# how could we easily center that title above the table with spaces?
title = "Flintstone Family Members"
puts title.center(40)
