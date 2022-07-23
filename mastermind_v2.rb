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
end

class Game
  include Gameplay

  def initialize
  end
end

game = Game.new
p game.introduction
