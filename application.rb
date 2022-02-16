# frozen_string_literal: true

# Models a hangman game instance
class Hangman
  def initialize
    puts "Welcome to Hangman!\nEnter 'quit' to quit at any time \n\nTry to guess the word: "
    new_word = generate_word.split('')
    p new_word
    spaces = create_blank_spaces(new_word)
    play(new_word, spaces)
  end

  protected

  def play(new_word, spaces)
    loop do
      print "\nGuess any letter: "
      input = gets.chomp
      break if input == 'quit'

      update_spaces(input, new_word, spaces) if new_word.include?(input)
      puts "\n"
    end
  end

  private

  def generate_word
    rand_num = rand(9893)
    words = File.open('dictonary.txt', 'r')
    File.readlines(words, chomp: true)[rand_num]
  end

  def create_blank_spaces(new_word)
    letters = Array.new(new_word.length) { nil }
    letters.each do |element|
      print '_ ' if element.nil?
    end
    puts "\n"
    letters
  end

  def update_spaces(input, new_word, spaces)
    new_word.each_with_index do |element, i|
      spaces[i] = input if element == input
    end
    spaces.each do |element|
      if element.nil?
        print '_ '
      else
        print "#{element} "
      end
    end
  end
end

Hangman.new
