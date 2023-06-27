require_relative 'chess_board'
require_relative 'chess_player'

class Game
    attr_accessor :player_1, :player_2, :board, :turn

    def initialise
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
            break if move_valid?
        end
    end

    def move_valid?
        # TODO
    end

    def switch_turn
        self.turn = turn == player_1 ? player_2 : player_1
    end
end