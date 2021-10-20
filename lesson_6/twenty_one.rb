# Twenty-One

=begin
1. Initialize deck
2. Deal cards to player and dealer
3. Player turn: hit or stay
  - repeat until bust or "stay"
4. If player bust, dealer wins.
5. Dealer turn: hit or stay
  - repeat until total >= 17
6. If dealer bust, player wins.
7. Compare cards and declare winner.
=end
require 'pry'

CARD_VALUES = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']
CARD_SUITS = ['Spade', 'Diamond', 'Club', 'Heart']
NUMBER_VALUES = { '2' => 2, '3' => 3, '4' => 4, '5' => 5, '6' => 6,
                  '7' => 7, '8' => 8, '9' => 9, '10' => 10, 'J' => 10,
                  'Q' => 10, 'K' => 10, 'A' => 11 }
LIMIT = 21
DEALER_HIT_LIMIT = 17
NUM_ROUNDS = 5

def prompt(msg)
  puts "=> #{msg}"
end

def initialize_score
  scoreboard = {:player => 0, :dealer => 0}
end

def initialize_deck
  deck = []
  CARD_VALUES.each do |value|
    CARD_SUITS.each do |suit|
      deck.push([value, suit])
    end
  end
  deck
end

def initial_deal(deck)
  player_cards = []
  dealer_cards = []
  2.times do |index|
    player_cards[index] = deck.delete(deck.sample)
    dealer_cards[index] = deck.delete(deck.sample)
  end
  [player_cards, dealer_cards]
end

def joinand(arr, delimiter=', ', word='and')
  case arr.size
  when 0 then ''
  when 1 then arr.first
  when 2 then arr.join(" #{word} ")
  else
    arr[-1] = "#{word} #{arr.last}"
    arr.join(delimiter)
  end
end

def display_table(player, dealer, flip = true)
  player_nums = player.map { |card| card[0] }
  dealer_nums = dealer.map { |card| card[0] }
  dealer_nums[0] = "Unknown card" unless flip
  puts "=============="
  prompt "Dealer has: #{joinand(dealer_nums)}"
  prompt "You have: #{joinand(player_nums)}"
  puts "=============="
end

def sum_hand(hand)
  sum = 0

  hand.each do |card_arr|
    sum += NUMBER_VALUES[card_arr[0]]
  end

  hand.select { |card| card[0] == 'A' }.count.times do
    sum -= 10 if sum > LIMIT
  end

  sum
end

def bust?(hand)
  sum_hand(hand) > LIMIT
end

def hit!(hand, deck)
  hand.push(deck.delete(deck.sample))
end

def choose_move
  move = nil
  loop do
    prompt "Enter H to Hit or S to Stay."
    move = gets.chomp.upcase
    break if move == 'H' || move == 'S'
    prompt "Invalid choice."
  end
  move
end

def player_move(player_hand, dealer_hand, deck)
  loop do # player move loop
    display_table(player_hand, dealer_hand, false)
    move = choose_move
    player_hand = hit!(player_hand, deck) if move == 'H'
    break if move == 'S' || bust?(player_hand)
  end
  player_hand
end

def dealer_move(player_hand, dealer_hand, deck)
  loop do # dealer move loop
    if sum_hand(dealer_hand) >= DEALER_HIT_LIMIT
      prompt "Dealer stayed."
      break
    else
      prompt "Dealer hit."
      dealer_hand = hit!(dealer_hand, deck)
      break if bust?(dealer_hand)
      display_table(player_hand, dealer_hand)
    end
  end
  dealer_hand
end

def detect_winner(player_hand, dealer_hand)
  player_sum = sum_hand(player_hand)
  dealer_sum = sum_hand(dealer_hand)
  if player_sum > LIMIT
    :player_busted
  elsif dealer_sum > LIMIT
    :dealer_busted
  elsif player_sum > dealer_sum
    :player_win
  elsif dealer_sum > player_sum
    :dealer_win
  else
    :tie
  end
end

def display_winner(player_hand, dealer_hand)
  result = detect_winner(player_hand, dealer_hand)
  case result
  when :player_busted
    prompt "You busted, dealer wins!"
  when :dealer_busted
    prompt "Dealer busted, you win!"
  when :player_win
    prompt "You win!"
  when :dealer_win
    prompt "Dealer wins!"
  when :tie
    prompt "It's a tie!"
  end
end

def increment_score!(score, player_hand, dealer_hand)
  result = detect_winner(player_hand, dealer_hand)
  case result
  when :player_busted
    score[:dealer] += 1
  when :dealer_busted
    score[:player] += 1
  when :dealer_win
    score[:dealer] += 1
  when :player_win
    score[:player] += 1
  end
  score
end

def display_score(score)
  puts "-------------"
  prompt "You have #{score[:player]} win(s), Dealer has #{score[:dealer]} win(s)."
end

def continue?
  prompt "Enter 'q' to quit this game to 5, any key to continue."
  answer = gets.chomp
  !answer.downcase.start_with?('q')
end

def champ?(score)
  score[:player] == NUM_ROUNDS || score[:dealer] == NUM_ROUNDS
end

def play_again?
  puts "-------------"
  prompt "Would you like to play again? y/n"
  ans = gets.chomp.downcase
  ans == 'y'
end

def conclude_game(player_hand, dealer_hand, score)
  display_table(player_hand, dealer_hand)
  display_winner(player_hand, dealer_hand)
  display_score(score)
end

def display_final_winner(score)
  if score[:player] == NUM_ROUNDS
    prompt "You are the champ!"
  elsif score[:dealer] == NUM_ROUNDS
    prompt "Dealer is the champ!"
  end
end

loop do # game loop
  system 'clear'
  prompt "Let's play Twenty-One, first to #{NUM_ROUNDS} wins is the champ!"
  prompt "Press any key to begin."
  ans = gets.chomp

  score = initialize_score

  loop do # single game loop
    deck = initialize_deck
    player_hand, dealer_hand = initial_deal(deck)

    # player turn
    system 'clear'
    prompt "It is your turn."
    player_hand = player_move(player_hand, dealer_hand, deck)
    if bust?(player_hand)
      score = increment_score!(score, player_hand, dealer_hand)
      conclude_game(player_hand, dealer_hand, score)
      break if champ?(score)
      continue? ? next : break
    end

    # dealer turn
    system 'clear'
    prompt "It is the dealer's turn."
    dealer_hand = dealer_move(player_hand, dealer_hand, deck)
    if bust?(dealer_hand)
      score = increment_score!(score, player_hand, dealer_hand)
      conclude_game(player_hand, dealer_hand, score)
      break if champ?(score)
      continue? ? next : break
    end

    score = increment_score!(score, player_hand, dealer_hand)
    conclude_game(player_hand, dealer_hand, score)
    break if champ?(score)
    continue? ? next : break
  end

  display_final_winner(score)
  break unless play_again?
end

prompt "Thanks for playing!"
