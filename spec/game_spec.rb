# frozen_string_literal: true

require './lib/game'
require './lib/board'

describe Game do
  before(:each) do
    @game = Game.new
    @game.instance_variable_set(:@board, instance_double(Board))
  end

  describe '#play_round' do
    it 'prevents play from continuing until a valid move is made' do
      symbol = 'R'
      name = 'Test'

      allow(@game).to receive(:_play_move).and_return(false, true)
      allow(@game).to receive(:_draw_board)
      allow(@game).to receive(:_check_for_win)
      allow(@game).to receive(:_check_for_full_board)

      expect { @game.play_round(symbol, name) }
        .to output(/Invalid move. Retry/).to_stdout
    end
  end
end
