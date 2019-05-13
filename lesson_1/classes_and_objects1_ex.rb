class MyCar
  attr_reader :year
  attr_accessor :color

  def initialize(y, c, m)
    @year = y
    @color = c
    @model = m
    @speed = 0
  end

  def speed_up(n)
    @speed += n
    puts "You are now going #{n} miles per hour."
  end

  def brake(n)
    @speed -= n
    "You have slowed down #{n} miles per hour."
  end

  def current_speed
    puts "You are now going #{@speed} miles per hour."
  end

  def shut_off
    @speed = 0
    puts "You have turned off the car."
  end

  def spray_paint(color)
    self.color = color
    puts "Your car is now #{color}."
  end
end

honda = MyCar.new(2015, 'silver', 'CRV')
honda.speed_up(30)
honda.brake(10)
honda.current_speed
honda.shut_off
honda.color = 'red'
puts honda.color
puts honda.year
honda.spray_paint('blue')




