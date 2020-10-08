# frozen_string_literal: true

require './lib/board'

describe Board do
  before(:each) do
    @board = Board.new
  end
  context '#draw_board' do
    it 'draws template correcty' do
      expect(@board.draw_board).to eql(['┌─┬─┬─┬─┬─┬─┬─┐',
                                        '│ │ │ │ │ │ │ │', '├─┼─┼─┼─┼─┼─┼─┤',
                                        '│ │ │ │ │ │ │ │', '├─┼─┼─┼─┼─┼─┼─┤',
                                        '│ │ │ │ │ │ │ │', '├─┼─┼─┼─┼─┼─┼─┤',
                                        '│ │ │ │ │ │ │ │', '├─┼─┼─┼─┼─┼─┼─┤',
                                        '│ │ │ │ │ │ │ │', '├─┼─┼─┼─┼─┼─┼─┤',
                                        '│ │ │ │ │ │ │ │',
                                        '└─┴─┴─┴─┴─┴─┴─┘'])
    end

    it 'draws board with colored moves on it correctly' do
      dummy_movements = Array.new(6) { Array.new(7, nil) }
      dummy_movements[0][0] = 'R'
      dummy_movements[4][3] = 'B'
      @board.instance_variable_set(:@movements, dummy_movements)
      expect(@board.draw_board).to eql(['┌─┬─┬─┬─┬─┬─┬─┐',
                                        "│\e[1;31m█\e[0m│ │ │ │ │ │ │", '├─┼─┼─┼─┼─┼─┼─┤',
                                        '│ │ │ │ │ │ │ │', '├─┼─┼─┼─┼─┼─┼─┤',
                                        '│ │ │ │ │ │ │ │', '├─┼─┼─┼─┼─┼─┼─┤',
                                        '│ │ │ │ │ │ │ │', '├─┼─┼─┼─┼─┼─┼─┤',
                                        "│ │ │ │\e[1;34m█\e[0m│ │ │ │", '├─┼─┼─┼─┼─┼─┼─┤',
                                        '│ │ │ │ │ │ │ │',
                                        '└─┴─┴─┴─┴─┴─┴─┘'])
    end
  end

  context '#play_move' do
    it 'adds a move to movement in correct column and shifts down to bottom row' do
      column = 1
      symbol = 'R'
      @board.play_move(column, symbol)
      expect(@board.draw_board).to eql(['┌─┬─┬─┬─┬─┬─┬─┐',
                                        '│ │ │ │ │ │ │ │', '├─┼─┼─┼─┼─┼─┼─┤',
                                        '│ │ │ │ │ │ │ │', '├─┼─┼─┼─┼─┼─┼─┤',
                                        '│ │ │ │ │ │ │ │', '├─┼─┼─┼─┼─┼─┼─┤',
                                        '│ │ │ │ │ │ │ │', '├─┼─┼─┼─┼─┼─┼─┤',
                                        '│ │ │ │ │ │ │ │', '├─┼─┼─┼─┼─┼─┼─┤',
                                        "│ │\e[1;31m█\e[0m│ │ │ │ │ │",
                                        '└─┴─┴─┴─┴─┴─┴─┘'])
    end

    it 'adds a move on top of previous moves in same column' do
      column = 2
      symbol = 'B'
      dummy_movements = Array.new(6) { Array.new(7, nil) }
      dummy_movements[5][2] = 'B'
      dummy_movements[4][2] = 'R'
      @board.instance_variable_set(:@movements, dummy_movements)

      @board.play_move(column, symbol)
      expect(@board.draw_board).to eql(['┌─┬─┬─┬─┬─┬─┬─┐',
                                        '│ │ │ │ │ │ │ │', '├─┼─┼─┼─┼─┼─┼─┤',
                                        '│ │ │ │ │ │ │ │', '├─┼─┼─┼─┼─┼─┼─┤',
                                        '│ │ │ │ │ │ │ │', '├─┼─┼─┼─┼─┼─┼─┤',
                                        "│ │ │\e[1;34m█\e[0m│ │ │ │ │", '├─┼─┼─┼─┼─┼─┼─┤',
                                        "│ │ │\e[1;31m█\e[0m│ │ │ │ │", '├─┼─┼─┼─┼─┼─┼─┤',
                                        "│ │ │\e[1;34m█\e[0m│ │ │ │ │",
                                        '└─┴─┴─┴─┴─┴─┴─┘'])
    end
  end
end
