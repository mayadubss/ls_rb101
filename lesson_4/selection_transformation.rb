# Lesson 4 Section 7. Selection and Transformation

# Modify the following code to be a destructive method

def double_numbers(numbers)
  doubled_numbers = []
  counter = 0

  loop do
    break if counter == numbers.size

    current_number = numbers[counter]
    doubled_numbers << current_number * 2

    counter += 1
  end

  doubled_numbers
end

# Modified version
def double_numbers!(numbers)
  counter = 0

  loop do
    break if counter >= numbers.size

    numbers[counter] *= 2

    counter += 1
  end

  numbers
end

my_numbers = [1, 4, 3, 7, 2, 6]
p double_numbers!(my_numbers) # => [2, 8, 6, 14, 4, 12]
p my_numbers.object_id


# Modify the following code to double the elements that are at odd indices

def double_odd_numbers(numbers)
  doubled_numbers = []
  counter = 0

  loop do
    break if counter == numbers.size

    current_number = numbers[counter]
    current_number *= 2 if current_number.odd?
    doubled_numbers << current_number

    counter += 1
  end

  doubled_numbers
end

# Modified version

def double_odd_indices(numbers)
  doubled_numbers = []
  counter = 0

  loop do
    break if counter == numbers.size

    current_number = numbers[counter]
    current_number *= 2 if counter.odd?
    doubled_numbers << current_number

    counter += 1
  end

  doubled_numbers
end

my_numbers = [1, 4, 3, 7, 2, 6]
p double_odd_indices(my_numbers)  # => [2, 4, 6, 14, 2, 6]

# not mutated
p my_numbers                      # => [1, 4, 3, 7, 2, 6]
