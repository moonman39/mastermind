# What we need to do!





# Gem to allow colors for text
require 'colorize'

module
end

class Game
end


# Gem to allow colors for text
require 'colorize'

# Human Colors
# Red, Orange, Yellow, Green, Blue, Magenta
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

  def print_gameboard
    12.times {puts self.gameboard.join(" ")}
  end

  def introduction
    puts "\nPlease enter your color guesses one at a time."
    puts "\nYour options are red, orange, yellow, green, blue, and magenta"
  end

  def get_human_choices
    self.human_choice_array = []
    until self.human_choice_array.length == 4 do
      puts "\nEnter a color guess to crack the code:"
      color = gets.chomp.downcase
      if self.valid_colors.include?(color)
        self.human_choice_array.push(color)
      else
        puts "\nPlease enter a valid color"
        self.get_human_choices
      end
    end
    p self.human_choice_array
  end

  def get_computer_choices
    self.computer_choice_array = [self.computer_choice, self.computer_choice, self.computer_choice, self.computer_choice]
  end


  def match_check
    self.human_choice_array.each_with_index do |human_color, human_index|
      self.computer_choice_array.each do |computer_color|
        if human_color == computer_color && human_index == computer_choice_array.index(computer_color)
          self.match_count += 1
        end
      end
    end
    self.code_cracked == true if self.match_count == 4
  end
end




class Game
  include Gameplay

  attr_accessor :gameboard, :computer_choice_array, :human_choice_array, :match_count, :includes_count, :code_cracked, :round_number
  attr_reader :valid_colors
  
  def initialize
    @gameboard = ["o", "o", "o", "o"]
    puts "\n"
    12.times { puts @gameboard.join(" ")}
    @computer_choice_array = []
    @valid_colors = ["red", "orange", "yellow", "green", "blue", "magenta"]
    @human_choice_array = []
    @match_count = 0
    @includes_count = 0
    @code_cracked = false
    @round_number = 1
  end

  def new_game
    self.introduction
    self.get_computer_choices
    while self.code_cracked == false || self.round_number < 13
      self.get_human_choices
      self.match_check
      self.round_number += 1
    end
  end
end

game = Game.new








  
array = ["red", "blue", "yellow", "green"]


new_array = array.map do |color|
  case color
  when "red"
    "o".red
  when "blue"
    "o".blue
  when "yellow"
    "o".yellow
  when "green"
    "o".green
  when "magenta"
    "o".magenta
  when "orange"
    "o".orange
  end
end

