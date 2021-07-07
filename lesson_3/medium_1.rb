# RB101_109 Lesson 3 Practice Problems: Medium 1

# Question 1
# Write a one-line program that prints "The Flintstones Rock!" 10 times, with the subsequent line indented 1 space to the right
10.times{|x| puts (" " * x) + "The Flintstones Rock!"}

# Question 2
=begin
The result of the following statement will be an error:
puts "the value of 40 + 2 is " + (40 + 2)
Why is this and what are two possible ways to fix this?
=> Can't use + to concatenate a string and an integer
=end
puts "the value of 40 + 2 is " + (40 + 2).to_s
puts "the value of 40 + 2 is #{40 + 2}"

# Question 3
=begin
Alan wrote the following method, which was intended to show all of the factors of the input number:
def factors(number)
  divisor = number
  factors = []
  begin
    factors << number / divisor if number % divisor == 0
    divisor -= 1
  end until divisor == 0
  factors
end
Alyssa noticed that this will fail if the input is 0, or a negative number, and asked Alan to change the loop.
How can you make this work without using begin/end/until? Note that we're not looking to find the factors for
0 or negative numbers, but we just want to handle it gracefully instead of raising an exception or going into an infinite loop.
=end
def factors(number)
  divisor = number
  factors = []
  while divisor > 0
    factors << number / divisor if number % divisor == 0
    divisor -= 1
  end
  factors
end
# Bonus 1: What is the purpose of number % divisor == 0
# => This ensures you only inclue numbers that divisor are evenly divisible by
# Bonus 2: What is the purpose of the second-to-last line (line 8) in the method (the factors before the method's end)?
# => This returns the final array of factors

# Question 4
=begin
Alyssa was asked to write an implementation of a rolling buffer.
Elements are added to the rolling buffer and if the buffer becomes full,
then new elements that are added will displace the oldest elements in the buffer.
She wrote two implementations saying, "Take your pick. Do you like << or + for modifying the buffer?".
Is there a difference between the two, other than what operator she chose to use to add an element to the buffer?

def rolling_buffer1(buffer, max_buffer_size, new_element)
  buffer << new_element
  buffer.shift if buffer.size > max_buffer_size
  buffer
end

def rolling_buffer2(input_array, max_buffer_size, new_element)
  buffer = input_array + [new_element]
  buffer.shift if buffer.size > max_buffer_size
  buffer
end

=> The implementation using + is not modifying the buffer that is passed into the method, the << is.
=end

# Question 5
=begin
Alyssa asked Ben to write up a basic implementation of a Fibonacci calculator.
A user passes in two numbers, and the calculator will keep computing the sequence until some limit is reached.
Ben coded up this implementation but complained that as soon as he ran it, he got an error.
Something about the limit variable. What's wrong with the code?
=end

def fib(first_num, second_num, limit)
  while first_num + second_num < limit
    sum = first_num + second_num
    first_num = second_num
    second_num = sum
  end
  sum
end

result = fib(0, 1, 15)
puts "result is #{result}"

# => the variable limit was defined outside of the method scope, made it one of the parameters of the method.

# Question 6
=begin
What is the output of the following code?

answer = 42

def mess_with_it(some_number)
  some_number += 8
end

new_answer = mess_with_it(answer)

p answer - 8

=> code will print 34. answer variable was not changed, just passed to the method mess_with_it


# Question 7

One day Spot was playing with the Munster family's home computer and he wrote a small program to mess with their demographic data:

munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

def mess_with_demographics(demo_hash)
  demo_hash.values.each do |family_member|
    family_member["age"] += 42
    family_member["gender"] = "other"
  end
end

After writing this method, he typed the following...and before Grandpa could stop him, he hit the Enter key with his tail:

mess_with_demographics(munsters)

Did the family's data get ransacked? Why or why not?

=> yes, the method points to the actual munster object and changes the values of age/gender


# Question 8

Method calls can take expressions as arguments. Suppose we define a method called rps as follows,
which follows the classic rules of rock-paper-scissors game,
but with a slight twist that it declares whatever hand was used in the tie as the result of that tie.

def rps(fist1, fist2)
  if fist1 == "rock"
    (fist2 == "paper") ? "paper" : "rock"
  elsif fist1 == "paper"
    (fist2 == "scissors") ? "scissors" : "paper"
  else
    (fist2 == "rock") ? "rock" : "scissors"
  end
end

What is the result of the following call?

puts rps(rps(rps("rock", "paper"), rps("rock", "scissors")), "rock")

rps(rps("paper", "rock"), "rock")
rps("paper", "rock")
=> "paper"


# Question 9

Consider these two simple methods:

def foo(param = "no")
  "yes"
end

def bar(param = "no")
  param == "no" ? "yes" : "no"
end

What would be the return value of the following method invocation?

bar(foo)

=> "no"
=end



