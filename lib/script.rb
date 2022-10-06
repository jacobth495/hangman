# frozen_string_literal: true

class Board
  attr_accessor :answer, :game_array, :guess

  def initialize
    words = []
    File.foreach('google_10000_words.txt') do |word|
      words << word.strip
    end
    @answer = words[rand(1..9894)].split('')
    @game_array = Array.new(answer.length, nil)
  end

  def guess
    @guess = gets.chomp
  end

  def check_guess
    if @guess.length == 1
      if answer.any?(@guess)
        game_arr_index = answer.index(@guess)
        game_array[game_arr_index] = @guess
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

  def show_game_array
    p game_array
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