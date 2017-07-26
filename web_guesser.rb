require "sinatra"
require "sinatra/reloader"

RANDOM_NUMBER = rand(100).to_s

get "/" do
  guess = params["guess"]

  message = guess ? message_when_there_is_a(guess) : message_before_guessing

  erb :index, locals: { message: message, number: RANDOM_NUMBER }
end

def message_when_there_is_a(guess)
  case guess <=> RANDOM_NUMBER
  when -1 then "The number is too low!"
  when  0 then "CORRECT! The secret number is #{RANDOM_NUMBER}."
  when  1 then "The number is too high!"
  end
end

def message_before_guessing
  "Please guess a number from 0 to 100."
end
