require "json"
require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10).join(' ')
  end

  def score
    input = params[:word].upcase
    url = "https://wagon-dictionary.herokuapp.com/#{input}"
    wordcheck = URI.open(url).read
    word = JSON.parse(wordcheck)
    # JSON.parse will return a hash, hence cannot use word[:found], use word["found"] instead
    # create an array
    input_arr = input.split('')
    letters_arr = params[:letters].split(' ')
    # subtracting arrays will leave unused elements in []
    check_valid = input_arr - letters_arr
    # if any, means there are letters that don't belong to letters_arr
    if check_valid.any?
      @response = "Sorry but #{input} can't be built out of #{params[:letters]}"
    elsif word["found"] == t
      @response = "Congratulations! #{input} is a valid English word!"
    elsif word["found"] == false
      @response = "Sorry but #{input} does not seem to be a valid English word.."
    end
  end
end
