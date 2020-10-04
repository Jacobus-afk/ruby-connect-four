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
  def draw_board
    generate_board
  end
end

if __FILE__ == $PROGRAM_NAME
  board = Board.new
  canvas = board.draw_board
  puts canvas
end
