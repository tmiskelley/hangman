# frozen_string_literal: true

# Models a hangman game instance
class Hangman
  def initialize
    puts "Welcome to Hangman!\nEnter 'quit' to quit at any time \n\nTry to guess the word: "
    @new_word = generate_word.split('')
    p @new_word
    @spaces = create_blank_spaces
    play
  end

  protected

  def play
    while @spaces.any?(&:nil?)
      print "\nGuess any letter: "
      input = gets.chomp
      break if input == 'quit'

      wrong_letter unless @new_word.include?(input)
      update_spaces(input)
    end
    puts "\nYou win!"
  end

  private

  def generate_word
    rand_num = rand(9893)
    words = File.open('dictonary.txt', 'r')
    File.readlines(words, chomp: true)[rand_num]
  end

  def create_blank_spaces
    letters = Array.new(@new_word.length) { nil }
    letters.each do |element|
      print '_ ' if element.nil?
    end
    puts "\n"
    letters
  end

  def update_spaces(input)
    @new_word.each_with_index do |element, i|
      @spaces[i] = input if element == input
    end
    @spaces.each do |element|
      if element.nil?
        print '_ '
      else
        print "#{element} "
      end
    end
    puts "\n"
  end

  def wrong_letter
    puts 'Incorrect.'
  end
end

Hangman.new
