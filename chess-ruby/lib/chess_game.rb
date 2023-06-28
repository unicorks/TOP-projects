require_relative 'chess_board'
require_relative 'chess_player'

class Game
    attr_accessor :player_1, :player_2, :board, :turn

    def initialize
        @player_1 = Player.new()
        @player_2 = Player.new()
        @board = Board.new()
        @turn = player_1
    end

    def get_move
        while true
            puts "Enter your move, #{turn.name} {#{turn.color.upcase}}"
            move = gets.chomp
            # check if move is valid, todo
            switch_turn if move_placed(move)
        end
    end

    def move_placed(move)
        letters = ('a'..'h').to_a
        nums = (1..8).to_a
        return false unless 
        move.length == 4 && 
        letters.include?(move[0]) && 
        letters.include?(move[2]) &&
        nums.include?(move[1].to_i) &&
        nums.include?(move[3].to_i)

        x, y = board.algebraic_to_coords(move[0, 2])
        b = board.board
        return false if b[x][y].color != turn.color
        true
    end

    def switch_turn
        self.turn = turn == player_1 ? player_2 : player_1
    end
end

game = Game.new()
print game.move_placed('a1b1')