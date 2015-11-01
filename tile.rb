
class Tile
  attr_accessor :is_bomb, :revealed, :value, :flagged
  def initialize value, board
    @board = board
    @value = value
    @is_bomb = false
    @revealed = false
    @flagged = false
  end

  def set_as_bomb
    @is_bomb = true
  end

  def reveal
    @revealed = true
  end

  def toggle_flag
    @flagged = !@flagged unless revealed
  end


  def to_s
    return "F" if flagged
    return "+" unless revealed
    return "*" if @is_bomb
    return value
  end
end
