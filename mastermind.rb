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
  
  def game_path
    if introduction == "computer"
      computer_code = [computer_choice, computer_choice, computer_choice, computer_choice]
      player_guess_introduction
    else
      player_code_input
    end
  end
  
  def player_guess_introduction
    puts "\nPlease enter your color guesses one at a time."
    puts "\nYour options are red, cyan, yellow, green, blue, and magenta"
  end

  def print_gameboard
    gameboard.each { |array| puts array.join(' ') }
  end

  def computer_choice
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

  def get_player_choices
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

  def player_code_input
    until player_code.length == 4
      puts "\nPlease enter your code colors one at a time:"
      color = gets.chomp.downcase
      if valid_colors.include?(color)
        player_code.push(color)
      else
        puts "\nPlease enter a valid color!"
        player_code_input
      end
    end
  end
    

  def match_check
    self.match_count = 0
    self.temporary_array = computer_code.map { |color| color }
    puts computer_code
    player_guesses.each_with_index do |player_color, index|
      temporary_array.each do |computer_color|
        if player_color == computer_color && index == temporary_array.index(computer_color)
          self.match_count += 1
          temporary_array[temporary_array.index(computer_color)] = 'match'
        end
      end
    end
    code_cracked == true if match_count == 4
  end

  def instance_check
    self.instance_count = 0
    player_guesses.each_with_index do |player_color, index|
      temporary_array.each do |computer_color|
        if player_color == computer_color && index != temporary_array.index(computer_color)
          if player_guesses.count(player_color) > temporary_array.count(computer_color)
            self.instance_count += temporary_array.count(computer_color)
            temporary_array.delete(computer_color)
          elsif player_guesses.count(player_color) < temporary_array.count(computer_color)
            self.instance_count += player_guesses.count(player_color)
            temporary_array.delete(computer_color)
          else
            self.instance_count += player_guesses.count(player_color)
            temporary_array.delete(computer_color)
          end
        end
      end
    end
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

  def update_board(match_count, instance_count)
    player_guesses.each_with_index do |color, index|
      case color
      when 'red'
        gameboard[rounds_left][index] = 'o'.red
      when 'cyan'
        gameboard[rounds_left][index] = 'o'.cyan
      when 'yellow'
        gameboard[rounds_left][index] = 'o'.yellow
      when 'green'
        gameboard[rounds_left][index] = 'o'.green
      when 'blue'
        gameboard[rounds_left][index] = 'o'.blue
      when 'magenta'
        gameboard[rounds_left][index] = 'o'.magenta
      end
    end
    update_matches(match_count)
    update_instances(instance_count)
  end

  def next_round
    self.rounds_left -= 1
    self.player_guesses = []
    self.temporary_array = []
  end
end

class Game
  include Gameplay

  attr_accessor :computer_code, :player_code, :player_guesses, :temporary_array,
                :gameboard, :rounds_left, :instance_count, :match_count, :code_cracked
  attr_reader :valid_colors

  def initialize
    @computer_code = []
    @valid_colors = %w[red cyan yellow green blue magenta]
    @player_guesses = []
    @player_code = []
    @code_cracked = false
    @temporary_array = []
    @rounds_left = 11
    @instance_count = 0
    @match_count = 0
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
    new_game
  end

  def new_game
    introduction
    # print_gameboard
    # until self.match_count == 4 || self.rounds_left.negative?
    #   get_player_choices
    #   match_check
    #   instance_check
    #   update_board(self.match_count, self.instance_count)
    #   next_round
    #   print_gameboard
    # end
    # p computer_code
  end
end

game = Game.new
