# TODO:  MAKE MASTERMIND
# MAKE CLASSES FOR CODEMAKER, CODEBREAKER, GAME

def Game

  def initialize(codemaker, codebreaker, board)
    @codemaker = codemaker
    @codebreaker = codebreaker
    @board = board
  end

  def self.instructions
    puts "Hello and welcome to Mastermind on the command line against the computer!
    - Please enter your guess in the form '1234' where each digit of the guess is a number 1-8
    - There are not supposed to be any duplicate digits in the code
    - For the hints, 'p' will be shown for a perfect guess, 'e' will be shown for a guess which exists in the code
    - There are 12 maximum turns to guess the code
    - Guesses will be on the left and hints will be on the right of the game board

    What would you like to be? Enter 0 for codemaker and 1 for codebreaker."
  end

  def start
    # know whether user will be codemaker or codebreaker
    while true
      choice = gets.chomp
      if choice  ==  "0" || choice  ==  "1"
        break
      else
        puts "Enter valid choice."
      end
    end

    # get name, initialise class instances
    choice = choice.to_i
    puts "Please enter your name: "
    name_of_user = gets.chomp
    if choice  ==  0
      while true
        code = gets.chomp.split('')
        valid = true
        for i in code
          if i <= 8 && i >= 1
            valid = false
            break
          end
        end
        if code.length > 4 || code.length < 4
          valid = false
        end
        if valid = true
          break
        else
          puts "Enter valid code."
        end
      end
      codebreaker = Codebreaker.new('computer')
      codemaker = Codemaker.new(name_of_user, code)
    elsif choice  ==  1
      codemaker = Codemaker.new('computer')
      codebreaker = Codebreaker.new(name_of_user)
    end
  end
end

def Board
  attr_accessor :guesses, :hints

  def initialize
    @guesses = Array.new(12, ["⬤", "⬤", "⬤", "⬤"])
    @hints = Array.new(12, ["○", "○", "○", "○"])
  end

  def print
    puts "╔═════════════╦═════════╗"
    for i in 0..11 do
      puts "║ #{@guesses[i][]}  #{@guesses[i][]}  #{@guesses[i][]}  #{@guesses[i][]}  ║ #{@hints[i][]} #{@hints[i][]} #{@hints[i][]} #{@hints[i][]} ║
      ╠═════════════╬═════════╣"
    end
    end
    puts "╚═════════════╩═════════╝"
  end
end

def Codemaker
  attr_reader :name, :code

  def initialize(name, code=[Random.rand(1..8), Random.rand(1..8), Random.rand(1..8), Random.rand(1..8)].join.to_i)
    @name = name
    @code = code.split('')    # verify the code if user is codemaker
  end
end

def Codebreaker
  attr_reader :name

  def initialize(name)
    @name = name
  end
end
