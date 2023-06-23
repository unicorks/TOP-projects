class Pawn
    attr_accessor :color, :valid_moves, :symbol, :board, :move_history

    def initialize(color, board, initial_pos)
        @color =  color
        @move_history = [initial_pos]
        @valid_moves = valid_moves
        @board = board
        @symbol = color == 'white' ? " ♙ " : " ♟︎ "
    end

    def valid_moves
        # todo
    end
end

class Knight
    attr_accessor :color, :valid_moves, :symbol, :board, :move_history

    def initialize(color, board, initial_pos)
        @color =  color
        @move_history = [initial_pos]
        @valid_moves = valid_moves
        @board = board
        @symbol = color == 'white' ? " ♘ " : " ♞ "
    end

    def valid_moves(current_pos=nil)
        tmp = move_history
        current_pos = tmp[-1] if current_pos == nil
        coords = algebraic_to_coords(current_pos)
        x, y = coords[0], coords[1]
        # values to calculate valid moves
        row = [ 2, 2, -2, -2, 1, 1, -1, -1 ]
        col = [ -1, 1, 1, -1, 2, -2, 2, -2 ]
        valid_moves = []
        for i in 0...row.length
            x1 = x + row[i]
            y1 = y + col[i]
            valid_moves << [x1, y1] unless (x1 < 0 || y1 < 0 || x1 >= 8 || y1 >= 8 || (board.board[x1, y1].color == self.color))
        end
    end
end

class Bishop
    attr_accessor :color, :valid_moves, :symbol, :board, :move_history

    def initialize(color, board, initial_pos)
        @color =  color
        @move_history = [initial_pos]
        @valid_moves = valid_moves
        @board = board
        @symbol = color == 'white' ? " ♗ " : " ♝ "
    end

    def valid_moves
        # todo
    end
end

class Rook
    attr_accessor :color, :valid_moves, :symbol, :board, :move_history

    def initialize(color, board, initial_pos)
        @color =  color
        @move_history = [initial_pos]        
        @valid_moves = valid_moves
        @board = board
        @symbol = color == 'white' ? " ♖ " : " ♜ "
    end

    def valid_moves
        # todo
    end
end

class Queen
    attr_accessor :color, :valid_moves, :symbol, :board, :move_history

    def initialize(color, board, initial_pos)
        @color =  color
        @move_history = [initial_pos]
        @valid_moves = valid_moves
        @board = board
        @symbol = color == 'white' ? " ♕ " : " ♛ "
    end

    def valid_moves
        # todo
    end
end

class King
    attr_accessor :color, :valid_moves, :symbol, :board, :move_history

    def initialize(color, board, initial_pos)
        @color =  color
        @move_history = [initial_pos]
        @valid_moves = valid_moves
        @board = board
        @symbol = color == 'white' ? " ♔ " : " ♚ "
    end

    def valid_moves
        # todo
    end
end

class EmptyPlace
    attr_accessor :symbol
    
    def initialize()
        @symbol =  "   "
    end
end
