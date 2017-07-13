require 'pry'
class Robot
  attr_accessor :coordinates, :bearing
  
  ORIENTATIONS = [:north, :east, :south, :west]
  def orient(direction)
    raise ArgumentError unless ORIENTATIONS.include?(direction) 
    @bearing = direction
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

class Simulator
  TRANSLATING_HASH = {'L' => :turn_left, 'R' => :turn_right, 'A' => :advance }
  
  def instructions(letters)
    letters.chars.map do |letter|
      TRANSLATING_HASH[letter]
    end
  end
  
  def place(robot, initial)
    robot.coordinates = [initial[:x], initial[:y] ]
    robot.bearing = initial[:direction]
  end
  
  def evaluate(robot, instruction_letters)
    instructions(instruction_letters).each do |movement|
      robot.send(movement)
    end
    robot
  end
end

# robot = Robot.new
#     simulator.place(robot, x: -2, y: 1, direction: :east)
#     simulator.evaluate(robot, 'RLAALAL')
#     assert_equal [0, 2], robot.coordinates
#     assert_equal :west, robot.bearing