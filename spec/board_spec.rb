# frozen_string_literal: true

require './lib/board'

describe Board do
  context '#draw_board' do
    before(:each) do
      @board = Board.new
    end
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

  end
end
