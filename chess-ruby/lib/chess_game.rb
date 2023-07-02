require_relative 'chess_board'
require_relative 'chess_player'

# MAJOR BUGS/TODO : checkmate detection doesnt work returns true everytime, problem in place_it func
# still dont work idk what to do

class Game
    attr_accessor :player_1, :player_2, :board, :turn, :white_king, :black_king

    def initialize(player_1=Player.new, player_2=Player.new)
        @player_1 = player_1
        @player_2 = player_2
        @board = Board.new()
        b = @board.board
        @turn = player_1
        @white_king = b[0][4]
        @black_king = b[7][4]
    end

    def get_move
        while true
            board.print_board
            puts "Enter your move, #{turn.name} {#{turn.color.upcase}}"
            move = gets.chomp
            # check for mate or stalemate
            king = turn.color == 'white' ? white_king : black_king
            oppn_moves = king.valid_moves_of_oppn
            mh = king.move_history
            current_pos_of_king = mh[-1]
            in_check = oppn_moves.include?(current_pos_of_king)
            if king.self_team_valid_moves.empty? && !(in_check)
                puts "It's likely a stalemate"
                exit
            end
            if in_check
                puts "Your king is in check btw. Stay careful!"
                mate = check_for_mate(current_pos_of_king)
                if mate
                    puts "You lose, #{turn.name}."
                    exit
                end
            end
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

    def place_it(current_pos, desired_pos, only_testing=false)
        x, y = current_pos[0], current_pos[1]
        x1, y1 = desired_pos[0], desired_pos[1]
        b = board.board
        piece_at_desired_pos = b[x1][y1]
        b[x1][y1] = b[x][y]
        b[x][y] = EmptyPlace.new
        b[x1][y1].move_history.append([x1, y1])
        board.board = b
        king = b[x1][y1] == 'white' ? white_king : black_king
        oppn_moves = king.valid_moves_of_oppn
        mh = king.move_history
        current_pos_of_king = mh[-1]
        in_check = oppn_moves.include?(current_pos_of_king) 
        if in_check || only_testing
            b[x1][y1].move_history.pop
            b[x][y] = b[x1][y1]
            b[x1][y1] = piece_at_desired_pos
            return false if in_check
        end
        true
    end

    def check_for_mate(king_pos)
        king = turn.color == 'white' ? white_king : black_king
        team_moves = king.self_team_valid_moves
        e = [false]
        for move in team_moves
            move_validity = place_it(king_pos, move, true)
            e << move_validity
        end
        return false if e.any?(true)
        true
    end
end

# comment this when testing
game = Game.new(Player.new('sa', 'white'), Player.new('da', 'black'))
game.get_move