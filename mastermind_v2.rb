# Gem to allow colors for text
require 'colorize'

module Gameplay
  # Basic introduction and player role choice
  def introduction
    puts "\nWelcome to Mastermind! Would you like to be the codebreaker or codemaker?"
    choice = gets.chomp.downcase
    until choice == "codebreaker" || choice == "codemaker"
      puts "Please enter either 'codebreaker' to guess the computer's code, or 'codemaker' to create your own code."
      choice = gets.chomp.downcase
    end
    choice
  end

  # Randomized computer code input
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

  # Player inputs for code creation and round guesses
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

  # Check for the number of matches and instances each round
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
    p round_array
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
    p round_array
    instance_count
  end
end

module Gameboard
  # Gameboard Functionality
  def print_gameboard
    gameboard.each { |array| puts array.join(' ') }
  end

  def update_matches(match_count)
    case match_count
      when 1
        gameboard[rounds_left].push('*'.red)
      when 2
        gameboard[rounds_left].push('*'.red, '*'.red)
      when 3
        gameboard[rounds_left].push('*'.red, '*'.red, '*'.red)
      when 4
        gameboard[rounds_left].push('*'.red, '*'.red, '*'.red, '*'.red)
    end
  end

  def update_instances(instance_count)
    case instance_count
      when 1
        gameboard[rounds_left].push('*')
      when 2
        gameboard[rounds_left].push('*', '*')
      when 3
        gameboard[rounds_left].push('*', '*', '*')
      when 4
        gameboard[rounds_left].push('*', '*', '*', '*')
    end
  end
end

class Game
  include Gameplay, Gameboard

  attr_accessor :computer_code, :player_code, :player_guesses, :round_array, :code_cracked,
                :match_count, :instance_count, :gameboard, :rounds_left

  attr_reader :valid_colors

  def initialize
    @valid_colors = %w(red cyan yellow green blue magenta)
    @computer_code = []
    @player_code = []
    @player_guesses = []
    @rounds_left = 11
    @code_cracked = false
    @gameboard = [
      ['o', 'o', 'o', 'o', '|'],
      ['o', 'o', 'o', 'o', '|'],
      ['o', 'o', 'o', 'o', '|'],
      ['o', 'o', 'o', 'o', '|'],
      ['o', 'o', 'o', 'o', '|'],
      ['o', 'o', 'o', 'o', '|'],
      ['o', 'o', 'o', 'o', '|'],
      ['o', 'o', 'o', 'o', '|'],
      ['o', 'o', 'o', 'o', '|'],
      ['o', 'o', 'o', 'o', '|'],
      ['o', 'o', 'o', 'o', '|'],
      ['o', 'o', 'o', 'o', '|']
    ]
  end
end

game = Game.new
game.computer_code_input
game.print_gameboard
game.player_guesses_input
game.match_check(game.player_guesses, game.computer_code)
game.instance_check(game.player_guesses)
game.update_matches(game.match_count)
game.update_instances(game.instance_count)
game.print_gameboard





