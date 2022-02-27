# frozen_string_literal: true

require 'json'

def generate_word
  rand_num = rand(9893)
  words = File.open('dictonary.txt', 'r')
  File.readlines(words, chomp: true)[rand_num]
end

# Models a hangman game instance
class Hangman
  def initialize(word)
    puts "Welcome to Hangman!\nEnter 'quit' to quit at any time"

    if File.exist?('save-data.json')
      new_game(word) unless load_game?
    else
      new_game(word)
    end
    play
  end

  protected

  def play
    print_wrong
    puts 'Try to guess the word:'
    @spaces.each do |element|
      item = element.nil? ? '_ ' : "#{element} "
      print item
    end
    print "\n"
    main_loop
    game_over
  end

  private

  def new_game(word)
    @new_word = word
    @spaces = Array.new(@new_word.length) { nil }
    @wrong_guesses = []
    @max_error = 6
  end

  def load_game?
    print 'Would you like to load your previous save? y/n: '
    choice = gets.chomp
    until %w[y n].include?(choice)
      puts 'Invalid input. Please enter y or n'
      choice = gets.chomp
    end
    load_game if choice == 'y'
  end

  def load_game
    data = JSON.parse(File.read('save-data.json'))
    @new_word = data['new_word']
    @spaces = data['spaces']
    @wrong_guesses = data['wrong_guesses']
    @max_error = data['max_error']
  end

  def main_loop
    while @spaces.any?(&:nil?)
      input = user_input

      wrong_letter(input) unless @new_word.include?(input)
      break if @max_error.zero?

      print_wrong
      update_spaces(input)
    end
  end

  def user_input
    print "\nGuess any letter: "
    input = gets.chomp
    if input == 'quit'
      quit_game
    elsif input.empty? || input.length > 1
      puts 'Invaild input, please enter one letter.'
    else
      return input
    end
    user_input
  end

  def update_spaces(input)
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

  def print_wrong
    print 'Incorrect guesses: '
    @wrong_guesses.each { |i| print "#{i} " }
    print "\n"
  end

  def game_over
    message = @max_error.zero? ? 'You lose!' : 'Congradulations! You win!'
    puts message
  end

  def quit_game
    print 'Save game? y/n: '
    choice = gets.chomp
    until %w[y n].include?(choice)
      puts 'Invaild input, please enter y or n'
      choice = gets.chomp
    end
    save_game if choice == 'y'
    exit(0)
  end

  def save_game
    save_data = {
      new_word: @new_word,
      spaces: @spaces,
      wrong_guesses: @wrong_guesses,
      max_error: @max_error
    }
    File.write('save-data.json', JSON.dump(save_data))
  end
end

Hangman.new(generate_word.split(''))
