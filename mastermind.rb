# What we need to do!
# 1. Get random computer choices for the code | DONE!
# 2. Get user guesses to crack the code
# 3. Check if user guesses are an exact match OR exist in the code, but don't match
# 4. Initialize a game
# 5. Have the game go for 4 rounds
# 6. Display the board and update the board to reflect player guesses
# 7. Check if player cracked the code OR ran out of rounds




# Gem to allow colors for text
require 'colorize'

module Gameplay
  def computer_choice
    number = (rand * 6).floor
    case number
    when 0
      "red"
    when 1
      "orange"
    when 2
      "yellow"
    when 3
      "green"
    when 4
      "blue"
    when 5
      "magenta"
    end
  end

  def introduction
    puts "\nPlease enter your color guesses one at a time."
    puts "\nYour options are red, orange, yellow, green, blue, and magenta"
  end
end

class Game
  include Gameplay

  attr_accessor :computer_code
  
  def initialize
    @computer_code = [self.computer_choice, self.computer_choice, self.computer_choice, self.computer_choice]
    self.introduction
  end
end


game = Game.new



