require_relative 'chess_board'
require_relative 'chess_player'

# MAJOR BUGS/TODO : test for stalemate, serialisation

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
            # check for mate or stalemate
            king = turn.color == 'white' ? white_king : black_king
            oppn_moves = king.valid_moves_of_oppn
            mh = king.move_history
            current_pos_of_king = mh[-1]
            in_check = oppn_moves.include?(current_pos_of_king)
            if !(in_check) && check_for_mate
                puts "It's likely a stalemate."
                exit
            end
            if in_check
                puts "#{turn.name}, your king is in check. Stay careful!"
                mate = check_for_mate
                if mate
                    puts "Damn, it's actually a checkmate. You lose, #{turn.name}."
                    exit
                end
            end
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

    def place_it(current_pos, desired_pos, only_testing=false)
        x, y = current_pos[0], current_pos[1]
        x1, y1 = desired_pos[0], desired_pos[1]
        b = board.board
        piece_at_desired_pos = b[x1][y1]
        b[x1][y1] = b[x][y]
        b[x][y] = EmptyPlace.new
        b[x1][y1].move_history.append([x1, y1])
        board.board = b
        king = b[x1][y1].color == 'white' ? white_king : black_king
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

        # promote pawn to queen
        if b[x1][y1].is_a?(Pawn)
            if b[x1][y1].color == 'white' && x1 == 7
                b[x1][y1] = Queen.new('white', board, [x1, y1])
            elsif b[x1][y1].color == 'black' && x1 == 0
                b[x1][y1] = Queen.new('black', board, [x1, y1])
            end
        end
        true
    end

    def check_for_mate
        # returns false if moves are possible, true if not
        king = turn.color == 'white' ? white_king : black_king
        team_moves = king.self_team_valid_moves
        e = [false]
        team_moves.each do |key, value|
            for i in value
                move_validity = place_it(key, i, true)
                e << move_validity
            end
        end
        return !(e.any?(true))
    end
end

def start
    puts "Hello and welcome to Chess on the command line, made by Saanvi. 
    The rules followed are the same as in regular chess. To place your moves, use algebraic chess notation.
    Eg. 'e2e4' to move the pawn at square e2 to square e4.
    You can save the game anytime by entering 'SAVE' when you are asked for your move.
    Special Moves Available: Promotion of pawn to queen
    To load a saved game, enter 0. To start a fresh game, enter 1."

    e = gets.chomp
    unless e == '0' || e == '1'
        puts "Looks like you don't wanna play :("
        exit
    end
    game = e == '0' ? load_game : Game.new
    game.get_move
end

start