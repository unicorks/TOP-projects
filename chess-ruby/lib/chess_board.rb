require_relative "chess_pieces"
require "colorize"

class Board
    attr_accessor :board

    def initialize
        @board = Array.new(8) { Array.new(8, EmptyPlace.new)}
        for i in 0..7
            @board[1][i] = Pawn.new('white', self, [1, i])
            @board[6][i] = Pawn.new('black', self, [6, 1])
        end
        for i in [0, 7]
            @board[0][i] = Rook.new('white', self, [0, i])
            @board[7][i] = Rook.new('black', self, [7, i])
        end
        for i in [1, 6]
            @board[0][i] = Knight.new('white', self, [0, i])
            @board[7][i] = Knight.new('black', self, [7, i])
        end
        for i in [2, 5]
            @board[0][i] = Bishop.new('white', self, [0, i])
            @board[7][i] = Bishop.new('black', self, [7, i])
        end
        @board[0][3] = Queen.new('white', self, [0, 3])
        @board[0][4] = King.new('white', self, [0, 4])
        @board[7][3] = Queen.new('black', self, [7, 3])
        @board[7][4] = King.new('black', self, [7, 4])
    end

    def algebraic_to_coords(algebra)
        return [algebra[1].to_i - 1, algebra[0].downcase.bytes.map { |b| b - 96 }[0] - 1]
    end

    def print_board
        tmp = self.board
        for i in 1..8
            for j in (0..7).step(2)
                if i.odd?
                    print tmp[-(i)][j].symbol.colorize( :background => :white)
                    print tmp[-(i)][j + 1].symbol.colorize( :background => :light_cyan)
                else
                    print tmp[-(i)][j].symbol.colorize( :background => :light_cyan)
                    print tmp[-(i)][j + 1].symbol.colorize( :background => :white)
                end
            end
            print "\n"
        end
    end
end