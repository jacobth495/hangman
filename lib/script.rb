# frozen_string_literal: true
require 'yaml'

class Board
  attr_accessor :answer, :game_array, :guess, :tried_guesses, :tries

  def initialize
    words = []
    @tried_guesses = []
    File.foreach('google_10000_words.txt') do |word|
      words << word.strip
    end
    @answer = words[rand(1..9894)].split('')
    @game_array = Array.new(answer.length, '_')
    @tries = 5
  end

  def guess
    @guess = gets.chomp
    if @guess == 'save'
      save()
      exit
    end
  end

  def check_guess
    if @guess.length == 1
      if answer.any?(@guess)
        answer.each_with_index do |l, i|
          if answer[i] == @guess
          game_array[i] = @guess
          end
        end
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

  def gameover?
    if tries <= 0
      true
      puts "Sorry you lost :'("
      puts show_answer
    elsif game_array.any?('_') == false
      true
      puts 'Congrats you won!!'
    else
      false
    end
  end

  def show_tried_guesses
    puts ''
    puts "Your guesses so far"
    p tried_guesses
  end

  def show_game_array
    puts 'Guess the word just like hangman minus the fancy graphics'
    p game_array.join
    puts "You have #{tries} tries left"
  end

  def show_answer
    answer = @answer.join
    puts "The answer was #{answer}"
  end

  def save
    #save_data = {:tries => tries, :answer => answer, :game_array => game_array, :tried_guesses => tried_guesses}
    File.open('saved.yaml','w') do |f|
      f.puts(self.to_yaml)
    end
  end

  def load
    File.open('saved.yaml', 'r') do |f|
      YAML.load(f, permitted_classes: [Board])
    end
  end
end

x = Board.new

puts 'Type load to start from saved game hit enter to continue'
a = gets.chomp
if a == 'load'
  x = x.load()
end

while x.gameover? == false
  x.show_tried_guesses
  x.show_game_array
  x.guess
  x.check_guess
end
