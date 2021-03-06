# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength

require './lib/board'

describe Board do
  before(:each) do
    @board = Board.new
    @dummy_movements = Array.new(6) { Array.new(7, nil) }
  end
  describe '#draw_board' do
    it 'draws template correcty' do
      expect(@board.draw_board).to eql(['┌─┬─┬─┬─┬─┬─┬─┐',
                                        '│ │ │ │ │ │ │ │', '├─┼─┼─┼─┼─┼─┼─┤',
                                        '│ │ │ │ │ │ │ │', '├─┼─┼─┼─┼─┼─┼─┤',
                                        '│ │ │ │ │ │ │ │', '├─┼─┼─┼─┼─┼─┼─┤',
                                        '│ │ │ │ │ │ │ │', '├─┼─┼─┼─┼─┼─┼─┤',
                                        '│ │ │ │ │ │ │ │', '├─┼─┼─┼─┼─┼─┼─┤',
                                        '│ │ │ │ │ │ │ │',
                                        '└─┴─┴─┴─┴─┴─┴─┘', ' 1 2 3 4 5 6 7'])
    end

    it 'draws board with colored moves on it correctly' do
      @dummy_movements[0][0] = 'R'
      @dummy_movements[4][3] = 'B'
      @dummy_movements[4][0] = 'B'
      @board.instance_variable_set(:@movements, @dummy_movements)
      expect(@board.draw_board).to eql(['┌─┬─┬─┬─┬─┬─┬─┐',
                                        "│\e[1;31m█\e[0m│ │ │ │ │ │ │", '├─┼─┼─┼─┼─┼─┼─┤',
                                        '│ │ │ │ │ │ │ │', '├─┼─┼─┼─┼─┼─┼─┤',
                                        '│ │ │ │ │ │ │ │', '├─┼─┼─┼─┼─┼─┼─┤',
                                        '│ │ │ │ │ │ │ │', '├─┼─┼─┼─┼─┼─┼─┤',
                                        "│\e[1;34m█\e[0m│ │ │\e[1;34m█\e[0m│ │ │ │", '├─┼─┼─┼─┼─┼─┼─┤',
                                        '│ │ │ │ │ │ │ │',
                                        '└─┴─┴─┴─┴─┴─┴─┘', ' 1 2 3 4 5 6 7'])
    end
  end

  describe '#play_move' do
    it 'adds a move to movement in correct column and shifts down to bottom row' do
      column = 1
      symbol = 'R'
      @board.play_move(column, symbol)
      current_movements = @board.instance_variable_get(:@movements)
      row = current_movements.length - 1
      expect(current_movements[row][column]).to eql('R')
    end

    it 'adds moves on top of previous moves in same column' do
      column = 2

      @dummy_movements[5][column] = 'B'
      @dummy_movements[4][column] = 'R'
      @board.instance_variable_set(:@movements, @dummy_movements)

      @board.play_move(column, 'B')
      @board.play_move(column, 'R')
      current_movements = @board.instance_variable_get(:@movements)

      expect(current_movements[5][column]).to eql('B')
      expect(current_movements[4][column]).to eql('R')
      expect(current_movements[3][column]).to eql('B')
      expect(current_movements[2][column]).to eql('R')
    end

    it 'checks if valid symbol is played' do
      column = 4
      symbol = 'G'
      expect(@board.play_move(column, symbol)).to eql false
    end

    it 'checks for column values out of range' do
      column = 8
      symbol = 'R'
      expect(@board.play_move(column, symbol)).to eql false
    end

    it 'checks if a row is full' do
      column = 3
      symbol = 'B'
      @dummy_movements[5][3] = 'B'
      @dummy_movements[4][3] = 'B'
      @dummy_movements[3][3] = 'B'
      @dummy_movements[2][3] = 'R'
      @dummy_movements[1][3] = 'R'
      @dummy_movements[0][3] = 'R'
      @board.instance_variable_set(:@movements, @dummy_movements)

      expect(@board.play_move(column, symbol)).to eql false
    end
  end

  describe '#check_for_full_board' do
    it 'returns true when no more moves can be made on a board' do
      row = 0
      @dummy_movements[row][0] = 'B'
      @dummy_movements[row][1] = 'B'
      @dummy_movements[row][2] = 'B'
      @dummy_movements[row][3] = 'R'
      @dummy_movements[row][4] = 'R'
      @dummy_movements[row][5] = 'R'
      @dummy_movements[row][6] = 'B'
      @board.instance_variable_set(:@movements, @dummy_movements)

      expect(@board.check_for_full_board).to eql true
    end

    it 'returns false when more moves can be made on a board' do
      row = 1
      @dummy_movements[row][0] = 'B'
      @dummy_movements[row][1] = 'B'
      @dummy_movements[row][2] = 'B'
      @dummy_movements[row][3] = 'R'
      @dummy_movements[row][4] = 'R'
      @dummy_movements[row][5] = 'R'
      @dummy_movements[row][6] = 'B'
      @board.instance_variable_set(:@movements, @dummy_movements)

      expect(@board.check_for_full_board).to eql false
    end
  end

  describe '#check_for_win' do
    it 'returns true on a horizontal win' do
      row = 5
      @dummy_movements[row][3] = 'R'
      @dummy_movements[row][4] = 'R'
      @dummy_movements[row][5] = 'R'
      @dummy_movements[row][6] = 'R'
      @board.instance_variable_set(:@movements, @dummy_movements)

      expect(@board.check_for_win('R')).to eql true
    end

    it 'returns false on a horizontal non-win' do
      row = 0
      @dummy_movements[row][0] = 'B'
      @dummy_movements[row][1] = 'B'
      @dummy_movements[row][2] = 'B'
      @dummy_movements[row][3] = 'R'
      @dummy_movements[row][4] = 'R'
      @dummy_movements[row][5] = 'R'
      @dummy_movements[row][6] = 'B'
      @board.instance_variable_set(:@movements, @dummy_movements)

      expect(@board.check_for_win('R')).to eql false
      expect(@board.check_for_win('B')).to eql false
    end

    it 'returns true on a vertical win' do
      column = 6
      @dummy_movements[2][column] = 'B'
      @dummy_movements[3][column] = 'B'
      @dummy_movements[4][column] = 'B'
      @dummy_movements[5][column] = 'B'
      @board.instance_variable_set(:@movements, @dummy_movements)

      expect(@board.check_for_win('B')).to eql true
    end

    it 'returns false on a vertical non-win' do
      column = 0
      @dummy_movements[0][column] = 'B'
      @dummy_movements[1][column] = 'B'
      @dummy_movements[2][column] = 'B'
      @dummy_movements[3][column] = 'R'
      @dummy_movements[4][column] = 'R'
      @dummy_movements[5][column] = 'R'
      @board.instance_variable_set(:@movements, @dummy_movements)

      expect(@board.check_for_win('R')).to eql false
      expect(@board.check_for_win('B')).to eql false
    end

    it 'returns true on a reverse diagonal win' do
      @dummy_movements[2][6] = 'R'
      @dummy_movements[3][5] = 'R'
      @dummy_movements[4][4] = 'R'
      @dummy_movements[5][3] = 'R'
      @board.instance_variable_set(:@movements, @dummy_movements)

      expect(@board.check_for_win('R')).to eql true
    end

    it 'returns true on a diagonal win' do
      @dummy_movements[2][3] = 'R'
      @dummy_movements[3][4] = 'R'
      @dummy_movements[4][5] = 'R'
      @dummy_movements[5][6] = 'R'
      @board.instance_variable_set(:@movements, @dummy_movements)

      expect(@board.check_for_win('R')).to eql true
    end

    it 'returns false on a diagonal non-win' do
      @dummy_movements[0][0] = 'B'
      @dummy_movements[1][1] = 'B'
      @dummy_movements[2][2] = 'B'
      @dummy_movements[3][3] = 'R'
      @dummy_movements[4][4] = 'R'
      @dummy_movements[5][5] = 'R'
      @board.instance_variable_set(:@movements, @dummy_movements)

      expect(@board.check_for_win('R')).to eql false
      expect(@board.check_for_win('B')).to eql false
    end
  end
end

# rubocop:enable Metrics/BlockLength
