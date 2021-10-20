# Tic Tac Toe

=begin
1. Display the inital empty 3x3 board.
2. Ask the user to mark a square.
3. Computer marks a square.
4. Display the updated board state.
5. If winner, display winner.
6. If board is full display tie.
7. If neither winner nor board is full, go to #2
8. Play again?
9. If yes, go to #1
10. Good bye!
=end
require 'pry'

INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
PLAYER_TURN = 'P'
COMPUTER_MARKER = 'O'
COMPUTER_TURN = 'C'
WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # cols
                [[1, 5, 9], [3, 5, 7]]              # diagonals
scoreboard = { 'Player' => 0, 'Computer' => 0 }

def prompt(msg)
  puts "=> #{msg}"
end

# rubocop: disable Metrics/AbcSize
def display_board(brd)
  system 'clear'
  puts "You are #{PLAYER_MARKER}. Computer is #{COMPUTER_MARKER}."
  puts ""
  puts "     |     |"
  puts "  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}"
  puts "     |     |"
  puts ""
end
# rubocop: enable Metrics/AbcSize

def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INITIAL_MARKER }
  new_board
end

def empty_squares(brd)
  brd.keys.select { |num| brd[num] == INITIAL_MARKER }
end

def joinor(arr, delimiter=', ', word='or')
  case arr.size
  when 0 then ''
  when 1 then arr.first
  when 2 then arr.join(" #{word} ")
  else
    arr[-1] = "#{word} #{arr.last}"
    arr.join(delimiter)
  end
end

def player_places_piece!(brd)
  square = ''
  loop do
    prompt "Choose a square (#{joinor(empty_squares(brd))}):"
    square = gets.chomp.to_i
    break if empty_squares(brd).include?(square)
    prompt "Sorry, that's not a valid choice."
  end

  brd[square] = PLAYER_MARKER
end

def detect_threat_square(brd, line)
  square = nil
  if  brd.values_at(*line).count(PLAYER_MARKER) == 2 &&
      brd.values_at(*line).count(INITIAL_MARKER) == 1
    threat_line = brd.select { |sqr, _marker| line.include?(sqr) }
    square = empty_squares(threat_line).first
  end
  square
end

def detect_winning_square(brd, line)
  square = nil
  if brd.values_at(*line).count(COMPUTER_MARKER) == 2 &&
     brd.values_at(*line).count(INITIAL_MARKER) == 1
    winning_line = brd.select { |sqr, _marker| line.include?(sqr) }
    square = empty_squares(winning_line).first
  end
  square
end

def computer_places_piece!(brd)
  square = nil
  WINNING_LINES.each do |line|
    if detect_winning_square(brd, line)
      square = detect_winning_square(brd, line)
      break
    elsif detect_threat_square(brd, line)
      square = detect_threat_square(brd, line)
      break
    elsif brd[5] == INITIAL_MARKER
      square = 5
      break
    else
      square = empty_squares(brd).sample
    end
  end
  brd[square] = COMPUTER_MARKER
end

def board_full?(brd)
  empty_squares(brd).empty?
end

def someone_won?(brd)
  !!detect_winner(brd)
end

def detect_winner(brd)
  WINNING_LINES.each do |line|
    # if brd[line[0]] == PLAYER_MARKER &&
    #    brd[line[1]] == PLAYER_MARKER &&
    #    brd[line[2]] == PLAYER_MARKER
    #   return 'Player'
    # elsif brd[line[0]] == COMPUTER_MARKER &&
    #       brd[line[1]] == COMPUTER_MARKER &&
    #       brd[line[2]] == COMPUTER_MARKER
    #   return 'Computer'
    # end
    if brd.values_at(*line).count(PLAYER_MARKER) == 3
      return 'Player'
    elsif brd.values_at(*line).count(COMPUTER_MARKER) == 3
      return 'Computer'
    end
  end
  nil
end

def score!(winner, scoreboard)
  scoreboard[winner] += 1
end

def five_wins?(scoreboard)
  scoreboard.values.include?(5)
end

def display_score(scoreboard)
  a = scoreboard.values
  if a.first == 1 && a.last != 1
    prompt "Player has #{scoreboard['Player']} win,
            Computer has #{scoreboard['Computer']} wins."
  elsif a.first != 1 && a.last == 1
    prompt "Player has #{scoreboard['Player']} wins,
            Computer has #{scoreboard['Computer']} win."
  elsif a.first == 1 && a.last == 1
    prompt "Player has #{scoreboard['Player']} win,
            Computer has #{scoreboard['Computer']} win."
  else
    prompt "Player has #{scoreboard['Player']} wins,
            Computer has #{scoreboard['Computer']} wins."
  end
end

def place_piece!(user, board)
  user == PLAYER_TURN ? player_places_piece!(board) : computer_places_piece!(board)
end

def choose_user
  user = nil
  loop do
    prompt "Who goes first? Type P for Player, C for Computer."
    user = gets.chomp.upcase
    break if user == PLAYER_TURN || user == COMPUTER_TURN
    prompt "That is not a valid choice."
  end
  user
end

def alternate_user(user)
  user = if user == PLAYER_TURN
           COMPUTER_TURN
         else
           PLAYER_TURN
         end
  user
end

loop do # full match loop
  prompt "Let's play Tic-Tac-Toe! First to 5 is the champ!"
  user = choose_user

  loop do # 5 game loop
    board = initialize_board

    loop do # single game loop
      display_board(board)

      place_piece!(user, board)
      user = alternate_user(user)
      break if someone_won?(board) || board_full?(board)
    end

    if someone_won?(board)
      display_board(board)

      score!(detect_winner(board), scoreboard)

      prompt "#{detect_winner(board)} won!"

      display_score(scoreboard)
    else
      prompt "It's a tie!"
    end

    break if five_wins?(scoreboard)
    prompt "Enter 'q' to quit this game of 5, any key to continue."
    answer = gets.chomp
    break if answer.downcase.start_with?('q')
  end

  if scoreboard['Player'] == 5
    prompt "Player has won 5 games! Player is the champ!"
  elsif scoreboard['Computer'] == 5
    prompt "Computer has won 5 games! Computer is the champ!"
  end

  prompt "Play best of 5 again? (y or n)"
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt "Thanks for playing Tic Tac Toe! Goodbye!"
