# Gem to allow colors for text
require 'colorize'

module Gameplay
  def introduction
    puts "\nWelcome to Mastermind! Would you like to be the codebreaker or codemaker?"
    choice = gets.chomp.downcase
    until choice == "codebreaker" || choice == "codemaker"
      puts "Please enter either 'codebreaker' to guess the computer's code, or 'codemaker' to create your own code."
      choice = gets.chomp.downcase
    end
    choice
  end

  def random_choice
    number = (rand * 6).floor
    case number
    when 0
      'red'
    when 1
      'cyan'
    when 2
      'yellow'
    when 3
      'green'
    when 4
      'blue'
    when 5
      'magenta'
    end
  end

  def computer_code_input
    self.computer_code = [random_choice, random_choice, random_choice, random_choice]
  end

  def player_code_input
    until player_code.length == 4
      puts "\nPlease enter your code colors one at a time from the following list of valid colors:"
      puts "Red, Cyan, Yellow, Green, Blue, & Magenta"
      color = gets.chomp.downcase
      if valid_colors.include?(color)
        player_code.push(color)
      else
        puts "\nPlease enter a valid color!"
        continue
      end
    end
  end

  def player_guesses_input
    until player_guesses.length == 4
      puts "\nGuess a color to crack the code!"
      color = gets.chomp.downcase
      if valid_colors.include?(color)
        player_guesses.push(color)
      else
        puts "\nPlease enter a valid color!"
        get_player_choices
      end
    end
  end

  def match_check(guesses, code)
    self.match_count = 0
    self.round_array = code.map { |color| color }
    guesses.each_with_index do |guesses_color, index|
      round_array.each do |code_color|
        if guesses_color == code_color && index == round_array.index(code_color)
          self.match_count += 1
          round_array[round_array.index(code_color)] = 'match'
        end
      end
    end
    code_cracked == true if match_count == 4
    match_count
  end

  def instance_check(guesses)
    self.instance_count = 0
    guesses.each_with_index do |guesses_color, index|
      round_array.each do |code_color|
        if guesses_color == code_color && index != round_array.index(code_color)
          if guesses.count(guesses_color) > round_array.count(code_color)
            self.instance_count += round_array.count(code_color)
            round_array.delete(code_color)
          elsif guesses.count(guesses_color) < round_array.count(code_color)
            self.instance_count += guesses.count(guesses_color)
            round_array.delete(code_color)
          else
            self.instance_count += guesses.count(guesses_color)
            round_array.delete(code_color)
          end
        end
      end
    end
    instance_count
  end
end

class Game
  include Gameplay

  attr_accessor :computer_code, :player_code, :player_guesses, :match_count, :round_array, :code_cracked,
                :match_count, :instance_count

  attr_reader :valid_colors

  def initialize
    @computer_code = []
    @player_code = []
    @player_guesses = []
    @code_cracked = false
    @valid_colors = %w(red cyan yellow green blue magenta)
  end
end

game = Game.new



