# Mortgage / Car Loan Calculator
=begin
 Input:
   Loan amount
   Annual Percentage Rate (APR)
   Loan duration
 Calulate:
   Monthly interest rate
   loan duration in months
   monthly payment
 Output:
   monthly payment
 Formula: m = p * (j / (1 - (1 + j)**(-n)))
   m = monthly payment
   p = loan amount
   j = monthly interest rate
   n = loan duration in months
=end

require 'yaml'
MESSAGES = YAML.load_file('loan_calc_messages.yml')

def prompt(message)
  puts "=> #{MESSAGES[message]}"
end

def duration_valid(duration)
  duration.to_i.to_s == duration
end

prompt("welcome")
name = gets.chomp
puts("=> Hi #{name}!")

loop do
  prompt("loan")
  loan_amount = gets.chomp.to_i

  prompt("apr")
  apr = gets.chomp
  monthly_interest_rate = ((apr.to_f / 100) / 12)

  # loan duration and validation
  months = ''
  loan_duration_f = ''
  loop do
    loop do
      prompt("loan_duration")
      loan_duration = gets.chomp

      if duration_valid(loan_duration)
        loan_duration_f = loan_duration.to_f
        break
      else
        prompt("valid_number")
      end
    end

    prompt("loan_units")
    loan_units = gets.chomp

    if loan_units.include? "month"
      months = loan_duration_f
      break
    elsif loan_units.include? "year"
      months = (loan_duration_f * 12)
      break
    else
      prompt("valid_loan_units")
    end
  end

  monthly_payment_long =  loan_amount *
                          (monthly_interest_rate /
                          (1 - (1 + monthly_interest_rate)**(-months)))
  monthly_payment_short = monthly_payment_long.round(2)

  puts "=> Your monthly loan payment is $#{monthly_payment_short}, good luck!"

  prompt("another_loan")
  ans = gets.chomp.downcase
  break unless ans == "y"
end

prompt("thanks")
