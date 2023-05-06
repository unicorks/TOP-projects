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

class Game
  attr_accessor :grid, :player1, :player2, :turn

  def initialize(player_1, player_2)
      @player1 = player_1
      @player2 = player_2
      @grid = Array.new(7, Array.new(6, '○')) 
      @turn = @player1
  end

  private

  def get_column
    while true
      puts "Where would you like to drop your marker, #{turn.name}?"
      column = gets.chomp.to_i
      tmp = grid
      break if column.positive? && column <= 7 && tmp[column][-1] == '○'
    end
    column
  end

  def print_grid
    tmp = grid
    for i in 1..6
      for j in 0..6
        print tmp[j][-(i)]
        print ' '
      end
      print "\n"
    end
    for k in 1..7
      print k
      print ' '
    end
  end
end