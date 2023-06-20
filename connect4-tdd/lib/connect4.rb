class Player
    attr_reader :name, :symbol
  
    def initialize(name=get_name, symbol=get_symbol)
      @name = name
      @symbol = symbol
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
      @grid = Array.new(7) { Array.new(6, '○') } 
      @turn = @player1
  end

  def start
    while true
      print_grid
      place_marker(get_column)
      switch_turn
      if self.grid.flatten.none?('○') 
        puts "It was a draw. Sad."
        exit
      end
    end
  end

  def get_column
    while true
      puts "Where would you like to drop your marker, #{turn.name}?"
      column = gets.chomp.to_i
      tmp = grid
      break if column.positive? && column <= 7 && tmp[column-1][-1] == '○'
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
    print "\n"
  end

  def place_marker(column)
    col = column ? column - 1 : get_column
    tmp = grid
    for i in 0..5
      if tmp[col][i] == '○'
        tmp[col][i] = turn.symbol
        self.grid = tmp
        exit if check_win(col, i, turn.symbol)
        break
      end
    end
  end

  def check_win(col, row, symbol)
    tmp = grid
    # vertical check
    if (grid[col].count(symbol) == 4) ||
      # horizontal check
      (tmp.collect_concat { |col| col[row] }.count(symbol) >= 4) ||
      diagonal_check(col, row, symbol) == true
      puts "#{turn.name} won. Congrats!"
      board.print
      return true
    end
  end

  def switch_turn
    self.turn = turn == player1 ? player2 : player1
  end

  def diagonal_check(col, row, symbol)
    # diagonal
    tmp = grid
    diagonal = [tmp[col][row]]
    c = col - 1
    r = row + 1
    unless col == 0 || row == 5
      until c < 0 || r > 5 do 
        diagonal.prepend(tmp[c][r])
        c -= 1
        r += 1
      end
    end
    c = col + 1
    r = row - 1
    unless col == 6 || row == 0
      until c > 6 || r < 0 do
        diagonal.append(tmp[c][r])
        c += 1 
        r -= 1
      end
    end
    if diagonal.count(symbol) >= 4
      return true
    end
  
    # antidiagonal
    anti = [tmp[col][row]]
    c = col + 1
    r = row + 1
    unless col == 6 || row == 5
      until c > 6 || r > 5 do 
        anti.prepend(tmp[c][r])
        c += 1
        r += 1
      end
    end
    c = col - 1
    r = row - 1
    unless col == 0 || row == 0
      until c < 0 || r < 0 do
        anti.append(tmp[c][r])
        c -= 1
        r -= 1
      end
    end
    if anti.count(symbol) >= 4
      return true
    end
  
    return false
  end
  
end


game = Game.new(Player.new(), Player.new())
game.start
