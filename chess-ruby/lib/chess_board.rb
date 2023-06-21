require_relative "chess_pieces"
require "colorize"

class Board
    attr_accessor :board

    def initialize
        @board = Array.new(8) { Array.new(8)}
    end

    def algebraic_to_coords(algebra)
        return [algebra[1].to_i - 1, algebra[0].downcase.bytes.map { |b| b - 96 }[0] - 1]
    end

    def print_board
        tmp = self.board
        for i in 1..8
            for j in (0..7).step(2)
                if i.odd?
                    print tmp[-(i)][j].colorize( :background => :white)
                    print tmp[-(i)][j + 1].colorize( :background => :light_black)
                else
                    print tmp[-(i)][j].colorize( :background => :light_black)
                    print tmp[-(i)][j + 1].colorize( :background => :white)
                end
            end
            print "\n"
        end
    end
end

board = Board.new()
board.print_board