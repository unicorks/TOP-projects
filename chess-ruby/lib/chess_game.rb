require_relative 'chess_board'
require_relative 'chess_player'

board = Board.new
tmp = board.board
rook = tmp[7][0]
print rook.valid_moves([3, 3])