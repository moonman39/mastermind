# What we need to do!
# 1. Get random computer choices for the code | DONE!
# 2. Get user guesses to crack the code | DONE!
# 3. Check if user guesses are an exact match OR exist in the code, but don't match | DONE!
# 4. Initialize a game | DONE!
# 5. Have the game go for 12 rounds | DONE!
# 6. Display the board and update the board to reflect player guesses
# 7. Check if player cracked the code OR ran out of rounds | DONE!




# Gem to allow colors for text
require 'colorize'

module Gameplay
  def introduction
    puts "\nPlease enter your color guesses one at a time."
    puts "\nYour options are red, orange, yellow, green, blue, and magenta"
  end

  def print_gameboard
    self.gameboard.each {|array| puts array.join(" ")}
  end

  def computer_choice
    number = (rand * 6).floor
    case number
    when 0
      "red"
    when 1
      "cyan"
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

  def get_player_choices
    until self.player_guesses.length == 4 do
      puts "\nGuess a color to crack the code!"
      color = gets.chomp.downcase
      if self.valid_colors.include?(color)
        self.player_guesses.push(color) 
      else
        puts "\nPlease enter a valid color!"
        self.get_player_choices
      end
    end
  end

  def match_check
    self.match_count = 0
    self.temporary_array = self.computer_code.map { |color| color }
    puts self.computer_code
    self.player_guesses.each_with_index do |player_color, index|
      self.temporary_array.each do |computer_color|
        if player_color == computer_color && index == self.temporary_array.index(computer_color)
          self.match_count += 1
          self.temporary_array[self.temporary_array.index(computer_color)] = "match"
        end
      end
    end
    self.code_cracked == true if match_count == 4
  end

  def instance_check
    self.instance_count = 0
    self.player_guesses.each_with_index do |player_color, index|
      self.temporary_array.each do |computer_color|
        if player_color == computer_color && index != self.temporary_array.index(computer_color)
          if self.player_guesses.count(player_color) > self.temporary_array.count(computer_color)
            self.instance_count += self.temporary_array.count(computer_color)
            self.temporary_array.delete(computer_color)
          elsif self.player_guesses.count(player_color) < self.temporary_array.count(computer_color)
            self.instance_count += self.player_guesses.count(player_color)
            self.temporary_array.delete(computer_color)
          else
            self.instance_count += self.player_guesses.count(player_color)
            self.temporary_array.delete(computer_color)
          end
        end
      end
    end
  end
  

  def update_matches(match_count)
    case match_count
    when 1
      self.gameboard[self.rounds_left].push("*".red)
    when 2
      self.gameboard[self.rounds_left].push("*".red, "*".red)
    when 3
      self.gameboard[self.rounds_left].push("*".red, "*".red, "*".red)
    when 4
      self.gameboard[self.rounds_left].push("*".red, "*".red, "*".red, "*".red)
    end
  end

  def update_instances(instance_count)
    case instance_count
    when 1
      self.gameboard[self.rounds_left].push("*")
    when 2
      self.gameboard[self.rounds_left].push("*", "*")
    when 3
      self.gameboard[self.rounds_left].push("*", "*", "*")
    when 4
      self.gameboard[self.rounds_left].push("*", "*", "*", "*")
    end
  end

  def update_board(match_count, instance_count)
    self.player_guesses.each_with_index do |color, index|
      case color
      when "red"
        self.gameboard[self.rounds_left][index] = "o".red
      when "cyan"
        self.gameboard[self.rounds_left][index] = "o".cyan
      when "yellow"
        self.gameboard[self.rounds_left][index] = "o".yellow
      when "green"
        self.gameboard[self.rounds_left][index] = "o".green
      when "blue"
        self.gameboard[self.rounds_left][index] = "o".blue
      when "magenta"
        self.gameboard[self.rounds_left][index] = "o".magenta
      end
    end
    self.update_matches(match_count)
    self.update_instances(instance_count)
  end

  def next_round
    self.rounds_left -= 1
    self.player_guesses = []
    self.temporary_array = []
  end
end

class Game
  include Gameplay

  attr_accessor :computer_code, :player_guesses, :code_cracked, :temporary_array, :gameboard, :rounds_left, :instance_count, :match_count
  attr_reader :valid_colors
  
  def initialize
    @computer_code = [self.computer_choice, self.computer_choice, self.computer_choice, self.computer_choice]
    @valid_colors = ["red", "cyan", "yellow", "green", "blue", "magenta"]
    @player_guesses = []
    @code_cracked = false
    @temporary_array = []
    @rounds_left = 11
    @instance_count = 0
    @match_count = 0
    @gameboard = [
      ["o", "o", "o", "o", "|"],
      ["o", "o", "o", "o", "|"],
      ["o", "o", "o", "o", "|"],
      ["o", "o", "o", "o", "|"],
      ["o", "o", "o", "o", "|"],
      ["o", "o", "o", "o", "|"],
      ["o", "o", "o", "o", "|"],
      ["o", "o", "o", "o", "|"],
      ["o", "o", "o", "o", "|"],
      ["o", "o", "o", "o", "|"],
      ["o", "o", "o", "o", "|"],
      ["o", "o", "o", "o", "|"],
    ]
    self.new_game
  end

  def new_game
    self.introduction
    self.print_gameboard
    until self.match_count == 4 || self.rounds_left < 0 do
      self.get_player_choices
      self.match_check
      self.instance_check
      self.update_board(self.match_count, self.instance_count)
      self.next_round
      self.print_gameboard
    end
    p self.computer_code
  end
end


game = Game.new




