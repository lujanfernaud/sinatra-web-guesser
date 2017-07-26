require "sinatra"
require "sinatra/reloader"

RANDOM_NUMBER = rand(100)

get "/" do
  "The secret number is " + RANDOM_NUMBER.to_s
end
