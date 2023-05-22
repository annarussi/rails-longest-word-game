require 'open-uri'
require 'json'

class GamesController < ApplicationController

  def new
    @letters = ("A".."Z").to_a.sample(10)
  end

  def score
    @attempt = params[:attempt].upcase
    @letters = params[:letters].split

    @is_english = english_word?(@attempt)
    @is_grid = grid_letter(@attempt, @letters)

  end

  private

  def english_word?(attempt)
    user_serialized = URI.open("https://wagon-dictionary.herokuapp.com/#{attempt}")
    json = JSON.parse(user_serialized.read)
    json['found']
  end

  def grid_letter(attempt, letters)
    attempt.chars.all? { |letter| attempt.count(letter) <= letters.count(letter) }
  end
end
