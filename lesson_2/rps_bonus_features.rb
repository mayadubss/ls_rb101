# Rock Paper Scissors against the computer
# We make a choice
# the computer makes a choice
# we display the winner

# to count wins
# if player wins, add to player win count
# if computer wins, add to computer win count
# after each round check if either player has 5 wins
# if they do have 5 wins display that they are the grand winner

VALID_CHOICES = %w(rock paper scissors spock lizard)

def prompt(message)
  Kernel.puts("=> #{message}")
end

def win?(first, second)
  winning_combos = {:rock => %w(scissors lizard),
                    :paper => %w(rock spock),
                    :spock => %w(rock scissors),
                    :lizard => %w(paper spock),
                    :scissors => %w(lizard paper)}
  true if winning_combos[first.to_sym].include?(second)
end

def display_result(player, computer)
  if win?(player, computer)
    prompt("You won!")
  elsif win?(computer, player)
    prompt("Computer won!")
  else
    prompt("It's a tie!")
  end
end

def count_wins(player, computer, score)
  if win?(player, computer)
    score[0] += 1
  elsif win?(computer, player)
    score[1] += 1
  end
end

def display_grand_winner(score)
  if score[0] >= 5
    prompt("You are the grand winner!")
  elsif score[1] >= 5
    prompt("The computer is the grand winner!")
  else
    prompt("No grand winner yet, you have #{score[0]}
            and the computer has #{score[1]},
            on to the next round!")
  end
end

loop do
  wins = [0, 0]
  loop do
    choice = ''
    short_choice = ''
    choices = <<-MSG
      #{VALID_CHOICES.join(', ')}
      "r" for rock
      "p" for paper
      "sc" for scissors
      "sp" for spock
      "l" for lizard
    MSG

    loop do
      prompt("Choose one: #{choices}")
      short_choice = Kernel.gets().chomp()
      choice = VALID_CHOICES.select { |word| word.start_with?(short_choice) }.join

      if VALID_CHOICES.include?(choice)
        break
      else
        prompt("That's not a valid choice.")
      end
    end

    computer_choice = VALID_CHOICES.sample

    Kernel.puts("You chose: #{choice}, computer chose: #{computer_choice}")
    display_result(choice, computer_choice)
    count_wins(choice, computer_choice, wins)
    display_grand_winner(wins)
    # moving the logic to a method makes the program easier to follow
    # through abstraction
    break if wins[0] >= 5 || wins[1] >= 5
  end

  prompt("Do you want to play again?")
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt("Thank you for playing! Goodbye!")
