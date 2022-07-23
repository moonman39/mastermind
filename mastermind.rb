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
    self.temporary_array = self.computer_code
    self.player_guesses.each_with_index do |player_color, index|
      self.computer_code.each do |computer_color|
        if player_color == computer_color && index == self.computer_code.index(computer_color)
          match_count += 1
          self.temporary_array[self.computer_code.index(computer_color)] = "match"
        end
      end
    end
    self.code_cracked == true if match_count == 0
    p match_count
  end

  def instance_check
    instance_count = 0
    self.player_guesses.each_with_index do |player_color, index|
      self.temporary_array.each do |computer_color|
        if player_color == computer_color && index != self.temporary_array.index(computer_color)
          if self.player_guesses.count(player_color) > self.temporary_array.count(computer_color)
            instance_count += self.temporary_array.count(computer_color)
            self.temporary_array.delete(computer_color)
          elsif self.player_guesses.count(player_color) < self.temporary_array.count(computer_color)
            instance_count += self.player_guesses.count(player_color)
            self.temporary_array.delete(computer_color)
          else
            instance_count += self.player_guesses.count(player_color)
            self.temporary_array.delete(computer_color)
          end
        end
      end
    end
    p instance_count
  end
end

class Game
  include Gameplay

  attr_accessor :computer_code, :player_guesses, :code_cracked, :temporary_array
  attr_reader :valid_colors
  
  def initialize
    # @computer_code = [self.computer_choice, self.computer_choice, self.computer_choice, self.computer_choice]
    @computer_code = ["orange", "red", "yellow", "green"]
    @valid_colors = ["red", "orange", "yellow", "green", "blue", "magenta"]
    @player_guesses = []
    @code_cracked = false
    @temporary_array = []
    self.new_game
  end

  def new_game
    self.introduction
    self.get_player_choices
    self.match_check
    self.instance_check
  end
end


game = Game.new



