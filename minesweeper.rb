load './board.rb'
load './tile.rb'

class Game

  attr_reader :board

  def initialize( size = 10, bombs = 5)
    @board = Board.new(size, bombs)
  end

  def play
    take_turn until board.over?
  end

  def take_turn
    board.render
    get_input
    evaluate

  end

  def over?
    board.won?
    board.lost?
  end
  def won?
    @board.every_bomb_flagged? || @board.every_non_bomb_revealed?
  end
  def lost?
    @board[@move].reveal == :bomb
  end

  def get_input
    puts "enter your move (x,y)"
    @move = gets.chomp.split(",").map(&:to_i)
  end

  def evaluate
    if board.valid_pos?(@move)
      board.process_move(@move)
    else
      puts "invalid move"
    end
  end
end

def reload
  load __FILE__
end

if __FILE__ == $0
p Board.new.grid.sample.sample
end
