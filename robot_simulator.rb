require 'pry'
class Robot
  ORIENTATIONS = [:north, :east, :south, :west]
  def orient(direction)
    raise ArgumentError unless ORIENTATIONS.include?(direction) 
    @bearing = direction
  end
  
  def bearing
    @bearing
  end
  
  def turn_right
    next_index = ORIENTATIONS.index(@bearing) + 1
    if next_index == 4
      next_index = 0
    end
    @bearing = ORIENTATIONS[next_index]
  end
  
  def turn_left
    next_index = ORIENTATIONS.index(@bearing) - 1
    @bearing = ORIENTATIONS[next_index]
  end
  
  def at(x, y)
    @coordinates = [x, y]
  end
  
  def coordinates
    @coordinates
  end
  
  def advance
    case @bearing
    when :north
      @coordinates[1] += 1
    when :east
      @coordinates[0] += 1
    when :south
      @coordinates[1] -= 1
    when :west
      @coordinates[0] -= 1
    end
  end
end