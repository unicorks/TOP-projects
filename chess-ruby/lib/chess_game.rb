require_relative 'chess_board'
require_relative 'chess_player'

# MAJOR BUGS/TODO : mechanism for declaring checkmate
# sorta crazy idea: try out every single valid move of self's team using place_it
# if none returns true, it is checkmate/stalemate based on whether or not king is in check at cp

class Game
    attr_accessor :player_1, :player_2, :board, :turn

    def initialize(player_1=Player.new, player_2=Player.new)
        @player_1 = player_1
        @player_2 = player_2
        @board = Board.new()
        @turn = player_1
    end

    def get_move
        while true
            board.print_board
            puts "Enter your move, #{turn.name} {#{turn.color.upcase}}"
            move = gets.chomp
            # check if move is valid
            switch_turn if move_placed(move)
        end
    end

    def move_placed(move)
        return false unless move_in_board?(move)

        x, y = board.algebraic_to_coords(move[0, 2])
        b = board.board

        return false if b[x][y].color != turn.color

        x1, y1 = board.algebraic_to_coords(move[2, 2])
        return false unless b[x][y].valid_moves.include?([x1, y1])
        unless place_it([x, y], [x1, y1])
            puts "Uh oh, your king is in check. Attempt another move."
            return false
        end
        true
    end

    def switch_turn
        self.turn = turn == player_1 ? player_2 : player_1
    end

    def move_in_board?(move)
        letters = ('a'..'h').to_a
        nums = (1..8).to_a
        return false unless 
        move.length == 4 && 
        letters.include?(move[0]) && 
        letters.include?(move[2]) &&
        nums.include?(move[1].to_i) &&
        nums.include?(move[3].to_i)
        true
    end

    def place_it(current_pos, desired_pos)
        x, y = current_pos[0], current_pos[1]
        x1, y1 = desired_pos[0], desired_pos[1]
        b = board.board
        piece_at_desired_pos = b[x1][y1]
        b[x1][y1] = b[x][y]
        b[x][y] = EmptyPlace.new
        board.board = b
        king = 'hi'
        for i in 0..7
            for j in 0..7
                if b[i][j].is_a?(King) && b[i][j].color == b[x1][y1].color
                    king = b[i][j]
                    break
                end
            end
            break if king != 'hi'
        end
        oppn_moves = king.valid_moves_of_oppn
        mh = king.move_history
        current_pos_of_king = mh[-1]
        if oppn_moves.include?(current_pos_of_king)
            b[x][y] = b[x1][y1]
            b[x1][y1] = piece_at_desired_pos
            return false
        end
        b[x1][y1].move_history.append([x1, y1])
        true
    end
end

# game = Game.new(Player.new('sa', 'white'), Player.new('da', 'black'))
# game.get_move