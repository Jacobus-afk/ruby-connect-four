# frozen_string_literal: true

require './lib/game'
require './lib/board'

describe Game do
  # let(:board) { instance_double('Board') }
  # let(:game) { Game.new }
  before(:each) do
    @game = Game.new
    @game.instance_variable_set(:@board, instance_double(Board))
  end

  describe '#play_round' do
    # before do
    #   allow(Board).to receive(:new).and_return(board)
    # end
    it 'prevents play from continuing until a valid move is made' do
      symbol = 'R'
      name = 'Test'
      # allow(@game).to receive(:_play_move).once.with(symbol, name)
      allow(@game).to receive(:_play_move).and_return(false, true)
      # (@game).to receive(:puts)
      allow(@game).to receive(:_draw_board)
      allow(@game).to receive(:_check_for_win)
      allow(@game).to receive(:_check_for_full_board)

      # play_move = double
      # allow(@game).to receive(:_play_move).and_return(true)
      # expect(@game).to receive(:puts)
      expect { @game.play_round(symbol, name) }
        .to output(/Invalid move. Retry/).to_stdout
    end
  end
end
