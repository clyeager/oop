#Add a class method to your MyCar class that calculates the gas mileage of any car.


def self.gas_mileage(gallons, miles)
  puts "You get #{miles / gallons} mpg."
end

MyCar.gas_mileage(15, 425)

#Override the to_s method to create a user friendly print out of your object.

def to_s
  puts "Your car is a #{year} #{color} {@model}."
end

#Why does this code give us a no method error undefined method `name='?

class Person
  attr_reader :name
  def initialize(name)
    @name = name
  end
end

bob = Person.new("Steve")
bob.name = "Bob"

#The reason is that we used the attr_reader method for :name. This only gives us a getter method, and 
#we need a setter method here. We can change this to attr_accessor :name or attr_writer :name for setter only

