# frozen_string_literal: true

require_relative 'knight'
# define chess board and legal moves
class Board
  attr_accessor :best_path, :history

  def initialize
    @best_path = nil
    @history = []
  end

  def show_parent(node, end_position)
    show_parent(node.parent_position, end_position) unless node.parent_position.nil?
    print "\n#{node.start_position}"
  end

  def find_path(start_position, end_position)
    @history << start_position

    node = Knight.new([start_position, nil], history)
    queue = []
    i = 1
    until target?(node, end_position)
      p "working#{i}"

      node.move_children.each do |child|
        queue.push([child, node]) if history.none? { |arr| arr == child }
        history << child
      end
      node = Knight.new(queue.shift, history)
      i += 1
    end

    show_parent(node, end_position)
    print "\n#{end_position}"
  end

  def legal?(coords)
    board.include?(coords)
  end

  def target?(node, end_node)
    if node.move_children.any? { |arr| arr == end_node }
      true
    else
      false
    end
  end
end
