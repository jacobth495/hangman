# frozen_string_literal: true
require 'json'

class Board
  attr_accessor :answer, :game_array, :guess, :tried_guesses, :tries

  def initialize
    words = []
    @tried_guesses = []
    File.foreach('google_10000_words.txt') do |word|
      words << word.strip
    end
    @answer = words[rand(1..9894)].split('')
    @game_array = Array.new(answer.length, nil)
    @tries = 3
  end

  def guess
    @guess = gets.chomp
  end

  def check_guess
    if @guess.length == 1
      if answer.any?(@guess)
        game_arr_index = answer.index(@guess)
        game_array[game_arr_index] = @guess
        tried_guesses << @guess
      else
        tried_guesses << @guess
        @tries -= 1
      end
    elsif @guess.length > 1
      equals = true
      answer.each_index do |i|
          if equals == false
            break
          end
          if answer[i] == @guess.split('')[i]
            equals = true
          else
            equals = false
          end
        end
      end
    if equals == true
      game_array.each_index do |i|
        game_array[i] = @guess.split('')[i]
      end
    end
  end

  def show_tried_guesses
    p tried_guesses
  end

  def show_game_array
    p game_array
    puts tries
  end

  def show_answer
    p answer
  end
end

x = Board.new

x.show_answer
x.guess
x.check_guess
x.show_game_array

p JSON.parse(x.to_s)