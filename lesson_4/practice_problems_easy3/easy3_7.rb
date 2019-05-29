class Light
  attr_accessor :brightness, :color

  def initialize(brightness, color)
    @brightness = brightness
    @color = color
  end

  def self.information
    return "I want to turn on the light with a brightness level of super high and a color of green"
  end

end

#What is used in the class, but adds no value?

#The return keyword in the self.information method, as a return is not needed because
#the last line of the code is the implicit return value.