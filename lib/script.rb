# frozen_string_literal: true

class Board
  attr_accessor :answer

  def initialize
    words = []
    File.foreach('google_10000_words.txt') do |word|
      words << word.strip
    end
    @answer = words[rand(1..9894)].split('')
  end

  def show_answer
    p answer
  end
end

myboard = Board.new

3.times do
  myboard.show_answer
end
