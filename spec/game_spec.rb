# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength

require './lib/game'
require './lib/board'

describe Game do
  before do
    @game = Game.new
    @game.instance_variable_set(:@board, instance_double(Board))
  end

  describe '#play_round' do
    it 'prevents play from continuing until a valid move is made' do
      symbol = 'R'
      name = 'Test'

      allow(@game).to receive(:_play_move).and_return(false, false, true)
      allow(@game).to receive(:_draw_board)
      allow(@game).to receive(:_check_for_win)
      allow(@game).to receive(:_check_for_full_board)

      expect { @game.play_round(symbol, name) }
        .to output("Invalid move. Retry\nInvalid move. Retry\n").to_stdout
    end

    it 'returns true on a valid move' do
      symbol = 'B'
      name = 'Test'

      allow(@game).to receive(:_play_move).and_return(true)
      allow(@game).to receive(:_draw_board)
      allow(@game).to receive(:_check_for_win)
      allow(@game).to receive(:_check_for_full_board)

      expect(@game.play_round(symbol, name)).to be true
    end
  end

  describe '#start_game' do
    it 'loops until game complete condition' do
      allow(@game).to receive(:_game_complete).and_return(false, false, true)
      allow(@game).to receive(:play_round)

      # @game.instance_variable_set(:@won, true)

      expect { @game.start_game }
        .to output("Game over\n").to_stdout
    end

    it 'stops looping if board is full' do
      allow(@game).to receive(:_game_complete).and_return(true)
      allow(@game).to receive(:play_round)

      # allow(@game).to receive(@won).and_return(false, true)

      @game.instance_variable_set(:@won, true)
      expect { @game.start_game }
        .to output("Game over\n").to_stdout
    end
  end
end

# rubocop:enable Metrics/BlockLength
