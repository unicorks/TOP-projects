class Pawn
    attr_accessor :color, :valid_moves, :symbol

    def initialize(color)
        @color =  color
        @valid_moves = valid_moves
        @move_history = []
        @symbol = color == 'white' ? " ♙ " : " ♟︎ "
    end

    def valid_moves
        # todo
    end
end

class Knight
    attr_accessor :color, :valid_moves, :symbol

    def initialize(color)
        @color =  color
        @valid_moves = valid_moves
        @move_history = []
        @symbol = color == 'white' ? " ♘ " : " ♞ "
    end

    def valid_moves
        # todo
    end
end

class Bishop
    attr_accessor :color, :valid_moves, :symbol

    def initialize(color)
        @color =  color
        @valid_moves = valid_moves
        @move_history = []
        @symbol = color == 'white' ? " ♗ " : " ♝ "
    end

    def valid_moves
        # todo
    end
end

class Rook
    attr_accessor :color, :valid_moves, :symbol

    def initialize(color)
        @color =  color
        @valid_moves = valid_moves
        @move_history = []
        @symbol = color == 'white' ? " ♖ " : " ♜ "
    end

    def valid_moves
        # todo
    end
end

class Queen
    attr_accessor :color, :valid_moves, :symbol

    def initialize(color)
        @color =  color
        @valid_moves = valid_moves
        @move_history = []
        @symbol = color == 'white' ? " ♕ " : " ♛ "
    end

    def valid_moves
        # todo
    end
end

class King
    attr_accessor :color, :valid_moves, :symbol

    def initialize(color)
        @color =  color
        @valid_moves = valid_moves
        @move_history = []
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