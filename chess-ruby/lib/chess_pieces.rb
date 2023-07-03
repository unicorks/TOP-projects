class Pawn
    attr_accessor :color, :symbol, :board, :move_history, :direction

    def initialize(color, board, initial_pos)
        @color =  color
        @move_history = [initial_pos]
        @board = board
        @symbol = color == 'white' ? " ♙ " : " ♟︎ "
        @direction = color == 'white' ? 1 : -1
    end

    def valid_moves(current_pos=nil, only_capturable_squares=false)
        b = board.board
        tmp = move_history
        current_pos = tmp[-1] if current_pos == nil
        x1, y1 = current_pos[0], current_pos[1]
        valid_moves = []
        x = x1 + direction
        x2 = x1 + (2*direction)
        valid_moves << [x, y1] unless (x < 0 || y1 < 0 || x >= 8 || y1 >= 8 || (b[x][y1].color != 'e'))
        valid_moves << [x2, y1] unless (move_history.length != 1 || x2 < 0 || y1 < 0 || x2 >= 8 || y1 >= 8 || (b[x2][y1].color != 'e'))
        capturable_squares = []
        for i in [y1-1, y1+1]
            unless only_capturable_squares
                valid_moves << [x, i] unless (x < 0 || i < 0 || x >= 8 || i >= 8 || (b[x][i].color == self.color) || (b[x][i].color == 'e'))
            end
                capturable_squares << [x, i] unless (x < 0 || i < 0 || x >= 8 || i >= 8 || (b[x][i].color == self.color))
        end
        return capturable_squares if only_capturable_squares
        valid_moves
    end
end

class Knight
    attr_accessor :color, :symbol, :board, :move_history

    def initialize(color, board, initial_pos)
        @color =  color
        @move_history = [initial_pos]
        @board = board
        @symbol = color == 'white' ? " ♘ " : " ♞ "
    end

    def valid_moves(current_pos=nil)
        b = board.board
        tmp = move_history
        current_pos = tmp[-1] if current_pos == nil
        coords = current_pos
        x, y = coords[0], coords[1]
        # values to calculate valid moves
        row = [ 2, 2, -2, -2, 1, 1, -1, -1 ]
        col = [ -1, 1, 1, -1, 2, -2, 2, -2 ]
        valid_moves = []
        for i in 0...row.length
            x1 = x + row[i]
            y1 = y + col[i]
            valid_moves << [x1, y1] unless (x1 < 0 || y1 < 0 || x1 >= 8 || y1 >= 8 || (b[x1][y1].color == self.color))
        end
        valid_moves
    end
end

class Bishop
    attr_accessor :color, :symbol, :board, :move_history

    def initialize(color, board, initial_pos)
        @color =  color
        @move_history = [initial_pos]
        @board = board
        @symbol = color == 'white' ? " ♗ " : " ♝ "
    end

    def valid_moves(current_pos=nil)
        b = board.board
        tmp = move_history
        current_pos = tmp[-1] if current_pos == nil
        x, y = current_pos[0], current_pos[1]
        valid_moves = []
        x1, y1 = current_pos[0] + 1, current_pos[1] + 1
        unless x == 7 || y == 7
            until x1 > 7 || y1 > 7 || b[x1][y1].color == self.color
                valid_moves.append([x1, y1])
                break if b[x1][y1].color != 'e'
                x1 += 1
                y1 += 1
            end
        end
        x1, y1 = current_pos[0] - 1, current_pos[1] - 1
        unless x == 0 || y == 0
            until x1 < 0 || y1 < 0 || b[x1][y1].color == self.color
                valid_moves.append([x1, y1])
                break if b[x1][y1].color != 'e'
                x1 -= 1
                y1 -= 1
            end
        end
        x1, y1 = current_pos[0] + 1, current_pos[1] - 1
        unless x == 7 || y == 0
            until x1 > 7 || y1 < 0 || b[x1][y1].color == self.color
                valid_moves.append([x1, y1])
                break if b[x1][y1].color != 'e'
                x1 += 1
                y1 -= 1
            end
        end
        x1, y1 = current_pos[0] - 1, current_pos[1] + 1
        unless x == 0 || y == 7
            until x1 < 0 || y1 > 7 || b[x1][y1].color == self.color
                valid_moves.append([x1, y1])
                break if b[x1][y1].color != 'e'
                x1 -= 1
                y1 += 1
            end
        end
        valid_moves
    end
end

class Rook
    attr_accessor :color, :symbol, :board, :move_history

    def initialize(color, board, initial_pos)
        @color =  color
        @move_history = [initial_pos]        
        @board = board
        @symbol = color == 'white' ? " ♖ " : " ♜ "
    end

    def valid_moves(current_pos=nil)
        b = board.board
        tmp = move_history
        current_pos = tmp[-1] if current_pos == nil
        x, y = current_pos[0], current_pos[1]
        valid_moves = []
        # vertical
        x1 = current_pos[0] + 1
        unless x == 7
            until x1 > 7 || b[x1][y].color == self.color
                valid_moves.append([x1, y])
                break if b[x1][y].color != 'e'
                x1 += 1
            end
        end
        x1 = current_pos[0] - 1
        unless x == 0
            until x1 < 0 || b[x1][y].color == self.color
                valid_moves.append([x1, y])
                break if b[x1][y].color != 'e'
                x1 -= 1
            end
        end
        # horizontal
        y1 = current_pos[1] - 1
        unless y == 0
            until y1 < 0 || b[x][y1].color == self.color
                valid_moves.append([x, y1])
                break if b[x][y1].color != 'e'
                y1 -= 1
            end
        end
        y1 = current_pos[1] + 1
        unless y == 7
            until y1 > 7 || b[x][y1].color == self.color
                valid_moves.append([x, y1])
                break if b[x][y1].color != 'e'
                y1 += 1
            end
        end
        valid_moves
    end
end

class Queen
    attr_accessor :color, :symbol, :board, :move_history

    def initialize(color, board, initial_pos)
        @color =  color
        @move_history = [initial_pos]
        @board = board
        @symbol = color == 'white' ? " ♕ " : " ♛ "
    end

    def valid_moves(current_pos=nil)
        tmp = move_history
        current_pos = tmp[-1] if current_pos == nil
        valid_moves = []
        imaginary_rook = Rook.new(self.color, self.board, nil)
        valid_moves << imaginary_rook.valid_moves(current_pos)
        imaginary_bishop = Bishop.new(self.color, self.board, nil)
        valid_moves << imaginary_bishop.valid_moves(current_pos)
        valid_moves.flatten(1)
    end
end

class King
    attr_accessor :color, :symbol, :board, :move_history

    def initialize(color, board, initial_pos)
        @color =  color
        @move_history = [initial_pos]
        @board = board
        @symbol = color == 'white' ? " ♔ " : " ♚ "
    end

    def valid_moves(current_pos=nil, only_capturable_squares=false)
        b = board.board
        tmp = move_history
        current_pos = tmp[-1] if current_pos == nil
        row = [1, 1, 1, 0, -1, -1, -1, 0]
        col = [-1, 0, 1, 1, 1, 0, -1, -1]
        x, y = current_pos[0], current_pos[1]
        valid_moves = []
        capturable_squares = []
        moves_of_oppn = valid_moves_of_oppn unless only_capturable_squares
        for i in 0...row.length
            x1 = x + row[i]
            y1 = y + col[i]
            unless only_capturable_squares
                valid_moves << [x1, y1] unless (x1 < 0 || y1 < 0 || x1 >= 8 || y1 >= 8 || (b[x1][y1].color == self.color) || moves_of_oppn.include?([x1, y1]))
            end
                capturable_squares << [x1, y1] unless (x1 < 0 || y1 < 0 || x1 >= 8 || y1 >= 8 || (b[x1][y1].color == self.color))
        end
        return capturable_squares if only_capturable_squares
        valid_moves
    end

    def valid_moves_of_oppn
        b = board.board
        moves = []
        for i in 0..7
            for j in 0..7
                unless b[i][j].color == 'e' || b[i][j].color == self.color
                    if b[i][j].is_a?(Pawn) || b[i][j].is_a?(King)
                        e = b[i][j].valid_moves(nil, true)
                    else
                        e = b[i][j].valid_moves
                    end
                    moves << e
                end
            end
        end
        moves.flatten(1)
    end

    def self_team_valid_moves
        b = board.board
        moves = {}
        for i in 0..7
            for j in 0..7
                if b[i][j].color == self.color
                    e = b[i][j].valid_moves
                    moves[[i, j]] = e
                end
            end
        end
        moves
    end
end

class EmptyPlace
    attr_accessor :symbol, :color
    
    def initialize()
        @symbol =  "   "
        @color = 'e'
    end
end
