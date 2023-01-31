class Player

  @@turn = 'O'

  def initialize(name, symbol)
    @name = name
    @symbol = symbol
  end

end

class Board

  attr_accessor :grid

  def initialize
    @grid = Array.new(9, " ")
  end

  private

  def check(c1, c2, c3)
    if c1 == c2 && c2 == c3 && c1 != ' ' && c2 != ' ' && c3 != ' '
      true
    else
      false
   end
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
        print("#{turn} wins")
        exit()
    # Vertical checks
    elsif check(@grid[0], @grid[3], @grid[6])==true || check(
      @grid[1], @grid[4], @grid[7])==true || check(
      @grid[2], @grid[5], @grid[8])==true
        print("#{turn} wins")
        exit()
    # Diagonal checks
    elsif check(@grid[0], @grid[4], @grid[8])==true || check(
      @grid[2], @grid[4], @grid[6])==true
        print("#{turn} wins")
        exit()
    end

end

# TODO: MAKE GAME FUNCTIONALITY