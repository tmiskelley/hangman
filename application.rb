# frozen_string_literal: true

def generate_word
  rand_num = rand(9893)
  words = File.open('dictonary.txt', 'r')
  File.readlines(words, chomp: true)[rand_num]
end

# Models a hangman game instance
class Hangman
  def initialize(word)
    puts "Welcome to Hangman!\nEnter 'quit' to quit at any time \n\nTry to guess the word: "

    @new_word = word
    p @new_word
    @spaces = Array.new(@new_word.length) { nil }
    @wrong_guesses = []
    @max_error = 6
    play
  end

  protected

  def play
    @spaces.each do |element|
      print '_ ' if element.nil?
    end
    print "\n"
    main_loop
    game_over
  end

  private

  def main_loop
    while @spaces.any?(&:nil?)
      input = user_input

      wrong_letter(input) unless @new_word.include?(input)
      break if @max_error.zero?

      print 'Incorrect guesses: '
      @wrong_guesses.each { |i| print "#{i} " }
      update_spaces(input)
    end
  end

  def user_input
    print "\nGuess any letter: "
    input = gets.chomp
    if input == 'quit'
      exit(0)
    elsif input.empty? || input.length > 1
      puts 'Invaild input, please enter one letter.'
    else
      return input
    end
    user_input
  end

  def update_spaces(input)
    puts "\n"
    @new_word.each_with_index do |element, i|
      @spaces[i] = input if element == input
    end

    @spaces.each do |element|
      item = element.nil? ? '_ ' : "#{element} "
      print item
    end
    puts "\n"
  end

  def wrong_letter(input)
    @max_error -= 1
    puts "Incorrect! You have #{@max_error} lives left"
    @wrong_guesses.push(input) unless input.empty?
  end

  def game_over
    message = @max_error.zero? ? 'You lose!' : 'Congradulations! You win!'
    puts message
  end
end

Hangman.new(generate_word.split(''))
