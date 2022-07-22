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

  def get_player_choices
    until self.player_guesses.length == 4 do
      puts "\nGuess a color to crack the code!"
      color = gets.chomp.downcase
      if self.valid_colors.include?(color)
        self.player_guesses.push(color)
      else
        puts "\n Please enter a valid color!"
        self.get_player_choices
      end
    end
  end

  def match_check
    match_count = 0
    self.player_guesses.each_with_index do |player_color, index|
      self.computer_code.each do |computer_color|
        if player_color == computer_color && index == self.computer_code.index(computer_color)
          match_count += 1
        end
      end
    end
    self.code_cracked == true if match_count == 0
    p match_count
  end
end

class Game
  include Gameplay

  attr_accessor :computer_code, :player_guesses, :code_cracked
  attr_reader :valid_colors
  
  def initialize
    @computer_code = [self.computer_choice, self.computer_choice, self.computer_choice, self.computer_choice]
    @valid_colors = ["red", "orange", "yellow", "green", "blue", "magenta"]
    @player_guesses = []
    @code_cracked = false
    self.new_game
  end

  def new_game
    self.introduction
    self.get_player_choices
    p self.computer_code
    p self.player_guesses
    self.match_check
  end
end


game = Game.new



