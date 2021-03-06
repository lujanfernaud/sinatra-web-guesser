require "sinatra"
require "sinatra/reloader"

@@random_number = rand(100).to_s
@@opportunities = 5
@@guessing      = true

get "/" do
  guess = params["guess"]
  cheat = params["cheat"]

  message = guess ? message_when_there_is_a(guess) : message_before_guessing

  erb :index, locals: { message:       message,
                        number:        @@random_number,
                        opportunities: @@opportunities,
                        guessing:      @@guessing,
                        cheat:         cheat }
end

get "/restart" do
  reset_variables
  redirect "/"
end

def message_when_there_is_a(guess)
  case guess <=> @@random_number
  when -1 then number_too_low
  when  0 then correct_number
  when  1 then number_too_high
  end
end

def number_too_low
  return you_lose unless opportunities?
  reduce_opportunities
  "The number is too low!"
end

def correct_number
  reduce_opportunities
  not_guessing_on_this_round
  "CORRECT! The secret number is #{@@random_number}."
end

def number_too_high
  return you_lose unless opportunities?
  reduce_opportunities
  "The number is too high!"
end

def you_lose
  reduce_opportunities
  not_guessing_on_this_round
  "YOU LOSE. The secret number was #{@@random_number}."
end

def opportunities?
  @@opportunities > 1
end

def reduce_opportunities
  @@opportunities -= 1
end

def not_guessing_on_this_round
  @@guessing = false
end

def message_before_guessing
  "Please guess a number from 0 to 100."
end

def reset_variables
  @@random_number = rand(100).to_s
  @@opportunities = 5
  @@guessing      = true
end
