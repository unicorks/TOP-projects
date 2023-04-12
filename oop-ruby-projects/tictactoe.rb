class Player
  attr_reader :name, :symbol

  def initialize()
    @name = get_name
    @symbol = get_symbol
  end

  def get_name
    puts "Enter player name: "
    name = gets.chomp
  end

  def get_symbol
    while true
      puts "Enter your symbol: "
      symbol = gets.chomp
      break if symbol.size == 1
    end
    symbol
  end
end

class Board
  attr_accessor :grid, :player1, :player2, :turn

  def initialize(player1, player2)
    @grid = [*1..9]
    @player1 = player1
    @player2 = player2
    @turn = @player1
  end

  private

  def check(c1, c2, c3)
    c1 == c2 && c2 == c3 && c1 != ' ' && c2 != ' ' && c3 != ' '
  end

  def print
    puts "    ---------
    | #{@grid[0]} #{@grid[1]} #{@grid[2]} |
    | #{@grid[3]} #{@grid[4]} #{@grid[5]} |
    | #{@grid[6]} #{@grid[7]} #{@grid[8]} |
    ---------"
  end

  def game_over?
    # Horizontal checks
    (check(@grid[0], @grid[1], @grid[2])==true || check(
    @grid[3], @grid[4], @grid[5])==true || check(
    @grid[6], @grid[7], @grid[8])==true) ||
    # Vertical checks
    (check(@grid[0], @grid[3], @grid[6])==true || check(
    @grid[1], @grid[4], @grid[7])==true || check(
    @grid[2], @grid[5], @grid[8])==true) ||
    # Diagonal checks
    (check(@grid[0], @grid[4], @grid[8])==true || check(
    @grid[2], @grid[4], @grid[6])==true)
  end

  def get_place
    while true
      puts "Where would you like to place your marker, #{turn.name}?"
      place = gets.chomp.to_i
      tmp = grid
      break if place.positive? && place < 10 && (tmp[place - 1].is_a? Integer)
    end
    place
  end

  def place_marker(place)
    place = get_place unless place
    tmp = grid
    tmp[place - 1] = turn.symbol
    self.grid = tmp
  end

  def declare_winner
    puts "#{turn.name} wins. Congrats."
    exit
  end

  public

  def start_game
    puts 'Let the game begin!'
    i = 0
    while i < 9
      print
      place_marker
      declare_winner if game_over?
      self.turn = turn == player1 ? player2 : player1
      i += 1
    end
    puts 'Draw.' if i == 9
  end
end

# GAME PROCESS:
# puts 'Welcome to Tic-Tac-Toe on the command line'
# player1 = Player.new()
# player2 = Player.new()
# board = Board.new(player1, player2)
# board.start_game
