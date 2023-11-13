require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def settings
    @letters = generate_random_letters(10) # Adjust the number of letters as needed
  end

  def score
    word = params[:word].upcase
    letters = params[:letters]

    if valid_word?(word) && valid_letters?(word, letters)
      @score = calculate_score(word)
      # render turbo_stream: turbo_stream.replace('score_result', partial: 'score_result')
    else
      @score = 0
      @error_message = "Invalid word or letters."
      # render turbo_stream: turbo_stream.replace('score_result', partial: 'score_result')
    end
  end


  private

  def valid_word?(word)
    # response = Net::HTTP.get(uri)
    # serialized_beatles = URI.open(filepath).read
    # JSON.parse(serialized_beatles)
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end

  def valid_letters?(word, letters)
    return false if letters.nil?

    word.chars.all? { |char| word.count(char) <= (letters.count(char) || 0) }
  end

  def calculate_score(word)
    time_penalty = 0 # Implement your own time penalty rules
    length_bonus = word.length
    total_score = length_bonus - time_penalty
    total_score.positive? ? total_score : 0
  end

  # def fetch_word_info(word)
  #   # filepath = "https://wagon-dictionary.herokuapp.com/#{word}"
  #   # response = Net::HTTP.get(uri)
  #   # serialized_beatles = URI.open(filepath).read
  #   # JSON.parse(serialized_beatles)
  #   response = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
  #   json = JSON.parse(response.read)
  #   json['found']
  # end

  def generate_random_letters(count)
    ('A'..'Z').to_a.sample(count).join
  end
end
