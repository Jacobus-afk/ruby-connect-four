# frozen_string_literal: true

# template used to draw connect4 board
module BoardTemplate
  TOP_STRUCTURE =    '┌─┬─┬─┬─┬─┬─┬─┐'
  MIDDLE_PLAYABLE =  '│ │ │ │ │ │ │ │'
  MIDDLE_STRUCTURE = '├─┼─┼─┼─┼─┼─┼─┤'
  BOTTOM_STRUCTURE = '└─┴─┴─┴─┴─┴─┴─┘'

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
        tmpval = @movements[y][x]
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
