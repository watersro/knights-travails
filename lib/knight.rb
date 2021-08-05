# frozen_string_literal: true

require_relative 'board'

# define knight piece, and all possible moves
class Knight
  attr_reader :chess_board, :move_children
  attr_accessor :start_position, :parent_position, :path

  def initialize(start_position, history)
    @start_position = start_position[0]
    @parent_position = start_position[1]
    @move_children = find_children(start_position, history)
  end

  def moves(move_num, start_coord)
    case move_num
    when 1
      [start_coord[0] + 2, start_coord[1] + 1]
    when 2
      [start_coord[0] + 2, start_coord[1] - 1]
    when 3
      [start_coord[0] - 2, start_coord[1] + 1]
    when 4
      [start_coord[0] - 2, start_coord[1] - 1]
    when 5
      [start_coord[0] + 1, start_coord[1] + 2]
    when 6
      [start_coord[0] + 1, start_coord[1] - 2]
    when 7
      [start_coord[0] - 1, start_coord[1] + 2]
    when 8
      [start_coord[0] - 1, start_coord[1] - 2]
    end
  end

  def find_children(start_position, history)
    children = []
    i = 1
    while i < 9
      next_move = moves(i, start_position[0])

      children << next_move if find_children_helper(next_move, history)
      i += 1
    end

    children
  end

  def find_children_helper(next_move, history)
    if valid?(next_move) && history.none? { |arr| arr == next_move }
      true
    else
      false
    end
  end

  def not_in_path?(move, path)
    if in_path?(move, path)
      false
    else
      true
    end
  end

  def path_empty?
    @path = [] unless @path.instance_of? Array
  end

  def in_path?(move, path)
    result = false

    path.each_with_index do |arr, _index|
      result = true if arr == move
    end
    result
  end

  def valid?(position)
    position[0].between?(0, 7) && position[1].between?(0, 7)
  end

  def parent_helper(pos_array)
    @start_position = pos_array[0]
    @parent_position = pos_array[1]
  end
end
