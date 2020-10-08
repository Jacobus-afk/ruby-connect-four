# frozen_string_literal: true

require './lib/colors.rb'

# template used to draw connect4 board
module BoardTemplate
  TOP_STRUCTURE = '┌─┬─┬─┬─┬─┬─┬─┐'
  MIDDLE_PLAYABLE = '│ │ │ │ │ │ │ │'
  MIDDLE_STRUCTURE = '├─┼─┼─┼─┼─┼─┼─┤'
  BOTTOM_STRUCTURE = '└─┴─┴─┴─┴─┴─┴─┘'

  COLOR_LETTERS = %w[R G Y B P C].freeze
  COLOR_METHODS = %i[red green yellow blue pink cyan black white].freeze

  def generate_board
    [TOP_STRUCTURE.dup,
     MIDDLE_PLAYABLE.dup, MIDDLE_STRUCTURE.dup,
     MIDDLE_PLAYABLE.dup, MIDDLE_STRUCTURE.dup,
     MIDDLE_PLAYABLE.dup, MIDDLE_STRUCTURE.dup,
     MIDDLE_PLAYABLE.dup, MIDDLE_STRUCTURE.dup,
     MIDDLE_PLAYABLE.dup, MIDDLE_STRUCTURE.dup,
     MIDDLE_PLAYABLE.dup,
     BOTTOM_STRUCTURE.dup]
  end

  def color_output(char)
    _find_color_method(COLOR_LETTERS.find_index(char))
  end

  def _find_color_method(color_idx)
    return nil if color_idx.nil? || !color_idx.between?(0, COLOR_METHODS.length - 1)

    '█'.send(COLOR_METHODS[color_idx])
  end
end

# board class
class Board
  include BoardTemplate

  def initialize
    @movements = Array.new(6) { Array.new(7, nil) }
  end

  def draw_board
    board_temp = generate_board
    # @movements.each do |x|
    # x.each do |y|
    (0..@movements.length - 1).each do |y|
      (0..@movements[y].length - 1).each do |x|
        tmpval = color_output(@movements[y][x])
        board_temp[2 * y + 1][2 * x + 1] = tmpval if tmpval
      end
    end
    board_temp
  end
end

if __FILE__ == $PROGRAM_NAME
  board = Board.new
  canvas = board.draw_board
  puts canvas
end
