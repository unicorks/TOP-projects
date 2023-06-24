require_relative 'chess_board'
require_relative 'chess_player'

board = Board.new
tmp = board.board
pawn = tmp[1][0]
print pawn.valid_moves([5, 0])