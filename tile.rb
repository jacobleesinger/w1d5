
class Tile
  attr_accessor :is_bomb, :revealed, :value
  def initialize value, board
    @board = board
    @value = value
    @is_bomb = false
    @revealed = false

  end

  def set_as_bomb
    @is_bomb = true
    @value = "-"
  end

  def reveal
    @revealed = true
  end

  def neighbor_bomb_count
    neighbors.select{|neighbor| neighbor.is_bomb}.count
  end

  # def inspect
  #   "the inspect value is #{self}"
  # end

  def face_value
    @revealed ? @value : "+"
  end

  def neighbors
    @board.get_neighbors_of self
  end

  def location
    @board.grid.each_with_index do |line,row|
      line.each_with_index do |other_tile, col|
        return [row, col] if self == other_tile
      end
    end
    raise 'tile not found!'
  end
end
