# frozen_string_literal: true

require './lib/board'

# player class
class Player
  attr_reader :name, :symbol
  def initialize(name, symbol)
    @name = name
    @symbol = symbol
  end
end

# game class
class Game
  def initialize
    @players = [Player.new('Player 1', 'R'),
                Player.new('Player 2', 'B')]
    @board = Board.new
    @won = false
    @board_full = false
  end

  def play_round(symbol, name)
    puts 'Invalid move. Retry' while _play_move(symbol, name) == false

    _draw_board
    _check_for_win(symbol)
    _check_for_full_board
    true
  end

  def start_game
    player_enumerator = @players.cycle
    until @won || @board_full
      player = player_enumerator.next
      play_round(player.symbol, player.name)
    end
    puts 'Game over'
    puts 'Board is full' if @board_full
    puts "#{player.name} won"
  end

  private

  def _play_move(symbol, name)
    print "#{name}, choose a slot(1 to 7): "
    move = gets.chomp.to_i
    return false if @board.play_move(move - 1, symbol) == false
  end

  def _draw_board
    system('cls') || system('clear')
    puts @board.draw_board
  end

  def _check_for_win(symbol)
    @won = @board.check_for_win(symbol)
  end

  def _check_for_full_board
    @board_full = @board.check_for_full_board
  end
end

if __FILE__ == $PROGRAM_NAME
  game = Game.new
  game.start_game
end
