require_relative 'board'
require_relative 'knight'

chess_board = Board.new

p chess_board.find_path([0, 0], [0, 7])
