require 'game_state'
require 'display'

class GameOfLifeDriver
  def initialize
    matrix = [
      [1, 1, 0, 0, 0],
      [1, 0, 0, 1, 0],
      [1, 0, 0, 1, 0],
      [1, 0, 1, 1, 1],
      [1, 0, 0, 1, 0],
    ]

    10.times do 
      Display.new(matrix).display
      matrix = GameState.new(matrix).advance.matrix
    end
  end
end

GameOfLifeDriver.new
