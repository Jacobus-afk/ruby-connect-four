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

  VALID_SYMBOLS = %w[R B].freeze

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
    # @movements is a 2d matrix of movements on board with coords[y][x]
    @movements = Array.new(6) { Array.new(7, nil) }
    @current_board = generate_board
    # @plots = []
  end

  def draw_board
    (0..@movements.length - 1).each do |y|
      (0..@movements[y].length - 1).each do |x|
        _plot_movement(y, x)
      end
    end
    # @current_board
    _add_color_to_board
  end

  def play_move(column, symbol, row = 0)
    unless @movements[row][column].nil? && VALID_SYMBOLS.include?(symbol) && column.between?(0, @movements.length - 1)
      return false
    end

    row += 1 while row < @movements.length && @movements[row][column].nil?

    @movements[row - 1][column] = symbol
    # return symbol if @movements[row][column]
  end

  def check_for_win(symbol)
    (0..@movements.length - 1).each do |y|
      (0..@movements[y].length - 1).each do |x|
        next unless @movements[y][x] == symbol

        return true if _check_horizontal_win(y, x)

        return true if _check_vertical_win(y, x)

        return true if _check_diagonal_win(y, x)
      end
    end
    false
  end

  private

  def _check_horizontal_win(pt_y, pt_x)
    return false if pt_x > 3

    horizontal_arr = [@movements[pt_y][pt_x],
                      @movements[pt_y][pt_x + 1],
                      @movements[pt_y][pt_x + 2],
                      @movements[pt_y][pt_x + 3]]
    horizontal_arr.uniq.size == 1
  end

  def _check_vertical_win(pt_y, pt_x)
    return false if pt_y > 2

    vertical_arr = [@movements[pt_y][pt_x],
                    @movements[pt_y + 1][pt_x],
                    @movements[pt_y + 2][pt_x],
                    @movements[pt_y + 3][pt_x]]
    vertical_arr.uniq.size == 1
  end

  def _check_diagonal_win(pt_y, pt_x)
    return false if pt_y > 2 || pt_x > 3

    diagonal_arr = [@movements[pt_y][pt_x],
                    @movements[pt_y + 1][pt_x + 1],
                    @movements[pt_y + 2][pt_x + 2],
                    @movements[pt_y + 3][pt_x + 3]]
    diagonal_arr.uniq.size == 1
  end

  def _plot_movement(pt_y, pt_x)
    tmpval = @movements[pt_y][pt_x]
    @current_board[2 * pt_y + 1][2 * pt_x + 1] = tmpval unless tmpval.nil?
  end

  def _add_color_to_board
    @current_board.map do |row|
      row.gsub('B', color_output('B')).gsub('R', color_output('R'))
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  board = Board.new
  board.play_move(5, 'R')
  board.play_move(5, 'R')
  board.play_move(0, 'B')
  canvas = board.draw_board
  puts canvas
  board.check_for_win('R')
end
