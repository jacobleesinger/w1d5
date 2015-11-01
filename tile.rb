
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
  end

  def reveal
    @revealed = true
  end


  def to_s
    return "+" unless revealed
    return "*" if @is_bomb
    return value
  end
end
