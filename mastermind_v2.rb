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
end

class Game
  include Gameplay

  attr_accessor :computer_code, :player_code

  attr_reader :valid_colors

  def initialize
    @computer_code = []
    @player_code = []
    @valid_colors = %w(red cyan yellow green blue magenta)
  end
end

game = Game.new


