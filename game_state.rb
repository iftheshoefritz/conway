class GameState
  attr_accessor :matrix

  def initialize(matrix)
    @matrix = deep_dup(matrix)
    @next_step = deep_dup(matrix)
  end

  def [](y)
    @matrix[y]
  end

  def advance
    iterate_cells do |val, y, x|
      kill_cell(y, x) if alive?(val) && count_neighbours(y, x) < 2
      kill_cell(y, x) if alive?(val) && count_neighbours(y, x) > 3
      resurrect_cell(y, x) if dead?(val) && count_neighbours(y, x) == 3
    end
    GameState.new(@next_step)
  end

  private

  def iterate_cells(&block)
    @matrix.each_with_index do |row, y|
      row.each_with_index do |cell, x|
        yield(cell, y, x)
      end
    end
  end

  def count_neighbours(y, x)
    count = 0
    ((y -1)..(y + 1)).each do |vert|
      ((x - 1)..(x + 1)).each do |horiz|
        count += @matrix[vert][horiz] if in_bounds?(vert, horiz) && !(vert == y && horiz == x)
      end
    end
    count
  end

  def alive?(val)
    val == 1
  end

  def dead?(val)
    val == 0
  end

  def in_bounds?(y, x)
    y >= 0 && y < @matrix.length && x >= 0 && x < @matrix[0].length
  end

  def kill_cell(y, x)
    @next_step[y][x] = 0
  end

  def resurrect_cell(y, x)
    @next_step[y][x] = 1
  end

  # Safe 2d array handling - array.dup is not sufficient!
  def deep_dup(matrix)
    Marshal.load(Marshal.dump(matrix))
  end
end
