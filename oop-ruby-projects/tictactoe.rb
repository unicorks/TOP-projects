class Player
  attr_reader :name, :symbol

  def initialize(name, symbol)
    @name = name
    @symbol = symbol
  end
end

class Board
  attr_accessor :grid

  def initialize
    @grid = [*1..9]
  end

  private

  def check(c1, c2, c3)
    c1 == c2 && c2 == c3 && c1 != ' ' && c2 != ' ' && c3 != ' '
  end

  public

  def print
    puts "---------
    | {@grid[0]} {@grid[1]} {@grid[2]} |
    | {@grid[3]} {@grid[4]} {@grid[5]} |
    | {@grid[6]} {@grid[7]} {@grid[8]} |
    ---------"
  end

  def checkwin
    # Horizontal checks
    if check(@grid[0], @grid[1], @grid[2])==true || check(
    @grid[3], @grid[4], @grid[5])==true || check(
    @grid[6], @grid[7], @grid[8])==true
      print("#{turn.name} wins")
      exit
    # Vertical checks
    elsif check(@grid[0], @grid[3], @grid[6])==true || check(
    @grid[1], @grid[4], @grid[7])==true || check(
    @grid[2], @grid[5], @grid[8])==true
      print("#{turn.name} wins")
      exit
    # Diagonal checks
    elsif check(@grid[0], @grid[4], @grid[8])==true || check(
    @grid[2], @grid[4], @grid[6])==true
      print("#{turn.name} wins")
      exit
    end
  end
end

# TODO: TEST THIS WHENEVER FREE
# KNOWN ISSUES: scope of symbol variables
puts 'Welcome to Tic-Tac-Toe on the command line'
puts 'What is the name of player 1?'
name1 = gets.chomp
loop do
  puts "#{name1}, enter your symbol: "
  symbol1 = gets.chomp
  break if symbol1.size == 1
end
puts 'What is the name of player 2?'
name2 = gets.chomp
loop do
  puts "#{name2}, enter your symbol: "
  symbol2 = gets.chomp
  break if symbol2.size == 1
end

player1 = Player.new(name1, symbol1)
player2 = Player.new(name2, symbol2)
board = Board.new

puts 'Let the game begin!'

i = 0
turn = player1
while i < 9
  board.print
  loop do
    puts "Where would you like to place your marker, #{turn.name}?"
    place = gets.chomp.to_i
    break if place.positive? && place < 10
  end
  tmp = board.grid
  tmp[place - 1] = turn.symbol
  board.grid = tmp
  board.checkwin
  turn = turn == player1 ? player2 : player1
  i += 1
end

puts 'Draw.' if i == 9
