class Cube
  def initialize(volume)
    @volume = volume
  end
end

#can we add to class to access instance variable?

class Cube
  attr_reader :volume

  def initialize(volume)
    @volume = volume
  end
end

#either add an attr_reader or an instance getter method that returns the instance 
#variable