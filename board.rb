require 'byebug'
class Board
  attr_reader :grid
  def initialize size = 10, bombs = 10
    @size = size
    @grid = Array.new(size) {Array.new(size) {Tile.new(0, self)}}
    seed_bombs(bombs)
  end

  def seed_bombs bombs
    count = 0
    until count == bombs
      spot = @grid.sample.sample
debugger
      unless spot.is_bomb
        spot.set_as_bomb
        spot.neighbors.each { |tile| tile.value += 1 unless tile.is_bomb}
      end
      count += 1
    end
    'seeded!'
  end

  def render
    @grid.each do |row|
      row.each do |tile|
        print tile.face_value.to_s + " "
      end
      puts
    end
    nil
  end

  def [] (row, column)
    @grid[row][column]
  end

  def []=(row, column, value)
    @grid[row][column] = value
  end

  def valid_pos?(pos)
    row, col = pos
    return false unless row.between?(0, @size)
    return false unless col.between?(0, @size)
    true
  end

  def each &prc
    @grid.each do |row|
      row.each do |el|
        prc.call(el)
      end
    end
  end

  def every_bomb_flagged?

  end

  def every_non_bomb_revealed?
    each do |tile|
      unless tile.is_bomb
        return false unless tile.revealed
      end
    end
    true
  end

  def get_neighbors_of tile
    row, col = find_tile_location tile
    # debugger
    neighbor_positions =[
      [row-1, col-1],
      [row-1, col],
      [row-1, col+1],
      [row, col-1],
      [row, col+1],
      [row+1, col-1],
      [row+1, col],
      [row+1, col+1],
    ]

    valid_neighbor_positions = neighbor_positions.select {|pos| valid_pos?(pos)}
    valid_neighbor_positions.map { |position| self[*position]}

  end

  def find_tile_location tile
    @grid.each_with_index do |line,row|
      line.each_with_index do |other_tile, col|
        return [row, col] if tile == other_tile
      end
    end
    raise 'tile not found!'
  end

  def get_tile_at_pos pos
    self[*pos]
  end

  def god_view
    @grid.each do |row|
      p row.map(&:value)
    end
    nil
  end
  def inspect
    'im a board!'
  end


end
