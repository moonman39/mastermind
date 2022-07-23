# Gem to allow colors for text
require 'colorize'

module Gameplay
  def introduction
    puts "\nWelcome to Mastermind! Would you like to guess the computer's code, or have the computer
          guess your code?"
    puts "\nEnter 'computer' to guess the computer's code \nEnter 'me' to have the computer guess your code"
    choice = gets.chomp.downcase
    until choice == "me" || choice == "computer"
      puts "Please enter either 'computer to guess the computer's code, or 'me' to create your own code."
      choice = gets.chomp.downcase
    end
    choice
  end
end

class Game
  include Gameplay

  def initialize
  end
end

game = Game.new
