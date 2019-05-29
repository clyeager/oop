module Speed
  def go_fast
    puts "I am a #{self.class} and going super fast!"
  end
end

class Car
  include Speed
  def go_slow
    puts "I am safe and driving slow."
  end
end

>> small_car = Car.new
>> small_car.go_fast
#I am a Car and going super fast!

#how does an instance object call to go_fast return the class name?

#This takes place because in the body of the go_fast method we are using string interpolation
# on self.class which returns the class of the calling object(self)