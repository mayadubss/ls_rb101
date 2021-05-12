# Practice Problems: Easy 1

# 1
# What would you expect the code to print?
numbers = [1, 2, 2, 3]
numbers.uniq

puts numbers
# I think it will print the full array: 1, 2, 2, 3 each on their own line, because uniq is non mutating

# 2
=begin
what is != and where should you use it? -> not equals to, used as a comparator
put ! before something, like !user_name -> not user_name, would evaluate to false because everything is truthy other than false and nil
put ! after something, like words.uniq! -> could be part of a method name that mutates the caller, words would be mutated to only consiist of the unique elements
put ? before something -> use as ternary if..else operator with :
put ? after something -> could be part of a method name
put !! before something, like !!user_name -> evaluates to true because user_name is truthy and it's a double negative
=end

# 3
# Replace the word "important" with "urgent" in this string
advice = "Few things in life are as important as house training your pet dinosaur."
advice_array = advice.split(" ")
advice_array[6] = "urgent"
final_array = advice_array.join(" ")
p final_array
# LS Solution -> advice.gsub!("important", "urgent")

# 4
# what do the two methods do?
numbers = [1, 2, 3, 4, 5]
numbers.delete_at(1) # This deletes the 2, because it is at index 1
# LS Note: the array is operated on directly and the returned value is the 1 that is removed

numbers = [1, 2, 3, 4, 5]
numbers.delete(1) # This deletes the 1, becuase it is looking for the 1
# LS Note: the array is operated on directly and the returned value is the 2 that is removed

# 5
# Programmatically determine if 42 lies between 10 and 100. Hint use the range object
puts (10..100).include?(42) # assumes we are including 100. Excluding 100 would be (10...100)
# another option is Range.cover? which can take another range as an argument

# 6
# show two different ways to put the expected "Four score and " in front of the string
famous_words = "seven years ago..."
# 1
famous_words_beginning = "For score and "
famous_words_full1 = famous_words_beginning + famous_words
puts famous_words_full1
# 2
famous_words_full2 = "For score and " << famous_words
puts famous_words_full2

# 7
# If we build an array like this:
flintstones = ["Fred", "Wilma"]
flintstones << ["Barney", "Betty"]
flintstones << ["BamBam", "Pebbles"]
# We will end up with a nested array, make it un-nested
p flintstones.flatten!

# 8
# Turn this into an array containing only two elements: Barney's name and Barney's number
flintstones = { "Fred" => 0, "Wilma" => 1, "Barney" => 2, "Betty" => 3, "BamBam" => 4, "Pebbles" => 5 }
barney_array = ["Barney", flintstones["Barney"]]
p barney_array
# LS solution: instance method #assoc takes a key and returns the array
p flintstones.assoc("Barney")
