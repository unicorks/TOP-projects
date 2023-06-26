require_relative 'chess_board'
require_relative 'chess_player'

board = Board.new
tmp = board.board
# king = tmp[0][4]
# print king.valid_moves([4, 3])

pawn = tmp[6][1]
print pawn.valid_moves(nil, true)