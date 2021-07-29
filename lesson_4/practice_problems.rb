# Lesson 4 Practice Problems: Additional Practice

# Practice Problem 1
# Turn this array into a hash where the names are the keys and the values are the positions in the array.
flintstones = ["Fred", "Barney", "Wilma", "Betty", "Pebbles", "BamBam"]
flintstones_hash = {}

flintstones.each_with_object({}) do |name, hash|
  hash[name] = flintstones.index(name)
end
# I think this works but I can't print the hash

flintstones.each_with_index do |name, index|
  flintstones_hash[name] = index
end

p flintstones_hash

# Practice Problem 2
# Add up all of the ages from the Munster family hash:
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }

age_sum = 0
ages.each do |key, value|
  age_sum += value
end
puts age_sum

# Another answer
ages.values.inject(:+)

# Practice Problem 3
# Remove people with age 100 and greater from the hash
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }

young_ages = ages.reject do |key, value|
              value >= 100
             end
puts young_ages
# Another answer
ages.keep_if { |_, age| age < 100 }

# Practice Problem 4
# Pick out the minimum age from our current Munster family hash:
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }

minimum_age = ages.values[0]
ages.each do |name, age|
  minimum_age = age if age < minimum_age
end
p minimum_age
# Another answer
ages.values.min

# Practice Problem 5
# Find the index of the first name that starts with "Be"
flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
result = 0
flintstones.each_with_index do |name, index|
  result = index if name.start_with?("Be")
end
p result
# I know this wouldn't work if there was another name starting with "Be" but I removed the return line so the other
# practice problems would run.
# Another answer
flintstones.index { |name| name[0, 2] == "Be" }

# Practice Problem 6
# Amend this array so that the names are all shortened to just the first three characters:
flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

flintstones.map! {|name| name[0, 3]}
puts "New array: #{flintstones}"

# Practice Problem 7
# Create a hash that expresses the frequency with which each letter occurs in this string:
# Assuming case matters
statement = "The Flintstones Rock"
letters = {}
statement.each_char do |letter|
  if letters.has_key?(letter)
    letters[letter] += 1
  else
    letters[letter] = 1
  end
end
p letters

# Practice Problem 8
# What happens when we modify an array while we are iterating over it? What would be output by this code?
numbers = [1, 2, 3, 4]
numbers.each do |number|
  p number
  numbers.shift(1)
end
# => I think it will print 1, 3 but the original array will be returned

# What would be output by this code?
numbers = [1, 2, 3, 4]
numbers.each do |number|
  p number
  numbers.pop(1)
end
# => This will print 1, 2 and the original array will be returned

# Practice Problem 9
# Ruby on Rails uses the method titleize to capitalize the first letter of each word in a string
# Write a version of titleize
words = "the flintstones rock"
split_words = words.split(" ")
split_words.map do |word|
  word.capitalize!
end
p split_words.join(" ")
# Can be one line:
words.split.map { |word| word.capitalize }.join(' ')

# Practice Problem 10
# Modify the hash such that each member of the Munster family has an additional "age_group" key
# that has one of three values describing the age group the family member is in (kid, adult, or senior).
=begin
  - age range definitions: a kid is in the age range 0 - 17, an adult is in the range 18 - 64 and a senior is aged 65+.
  - loop through the family members
  - check the age
  - set the key "age_group" to the appropriate age range
  - return the modified hash
=end
munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

munsters.each do |member, bio_hash|
  if (0...17).to_a.include?(bio_hash["age"])
    bio_hash["age_group"] = "kid"
  elsif (18...64).to_a.include?(bio_hash["age"])
    bio_hash["age_group"] = "adult"
  else
    bio_hash["age_group"] = "senior"
  end
end
p munsters

=begin
LS Solution using case and Range:
munsters.each do |name, details|
  case details["age"]
  when 0...18
    details["age_group"] = "kid"
  when 18...65
    details["age_group"] = "adult"
  else
    details["age_group"] = "senior"
  end
end
=end


