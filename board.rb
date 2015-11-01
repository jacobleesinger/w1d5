require 'byebug'
class Board
  attr_reader :grid
  def initialize size = 10, bombs = 10
    @size = size
    @grid = Array.new(size) {Array.new(size) {Tile.new(0, self)}}
    set_tile_values(grid, bombs)
  end

  def set_tile_values(grid, bombs)
    seed_bombs(bombs)
    set_bomb_counts(grid)
  end

  def seed_bombs(bombs)
    count = 0
    until count == bombs
      spot = grid.sample.sample
# debugger
      unless spot.is_bomb
        spot.set_as_bomb
      end
      count += 1
    end
  end

  def set_bomb_counts(grid)
    grid.each do |row|
      row.each do |tile|
        unless tile.is_bomb
          tile.value = neighbor_bomb_count(tile)
        end
      end
    end
  end


  def render
    @grid.each do |row|
      row.each do |tile|
        print tile.to_s
      end
      puts
    end
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

  def neighbors(tile)
    row, col = find_tile_location(tile)
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

  def neighbor_bomb_count(tile)
    new_neighbors = neighbors(tile)
    new_neighbors.select { |neighbor| neighbor.is_bomb }.count
  end

  def find_tile_location(tile)
    @grid.each_with_index do |line,row|
      line.each_with_index do |other_tile, col|
        return [row, col] if tile == other_tile
      end
    end
    raise 'tile not found!'
  end

  def get_tile_at_pos(pos)
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
