=begin
1.Create a superclass called Vehicle for your MyCar class to inherit from and move the behavior that isn't
 specific to the MyCar class to the superclass. Create a constant in your MyCar class that stores information
 about the vehicle that makes it different from other types of Vehicles.
2.Add a class variable to your superclass that can keep track of the number of objects created that inherit
 from the superclass. Create a method to print out the value of this class variable as well.
3.Create a module that you can mix in to ONE of your subclasses that describes a behavior unique to that subclass.
4.Print to the screen your method lookup for the classes that you have created.
5.Move all of the methods from the MyCar class that also pertain to the MyTruck class into the Vehicle class.
 Make sure that all of your previous method calls are working when you are finished.
6.Write a method called age that calls a private method to calculate the age of the 
vehicle. Make sure the private method is not available from outside of the class. 
You'll need to use Ruby's built-in Time class to help.
=end

module Motorcycle
  def doors
    puts "I have no doors!"
  end
end

class Vehicle
  attr_reader :year, :model
  attr_accessor :color
  @@number_of_vehicles = 0

  def initialize(year, model, color)
    @year = year
    @model = model
    @color = color
    @speed = 0
    @@number_of_vehicles += 1
  end

  def self.number_of_vehicles
    p "There are #{@@number_of_vehicles} vehicles."
  end

  def self.gas_mileage(gallons, miles)
    puts "You get #{miles / gallons} mpg."
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
    puts "You have turned off the vehicle."
  end

  def spray_paint(color)
    self.color = color
    puts "Your vehicle is now #{color}."
  end

  def age
    puts "Your vehicle is #{calculate_age} years old!"
  end

  private

  def calculate_age
    Time.now.year - self.year
  end

end

class MyCar < Vehicle
  SUNROOF = true

  def to_s
    puts "Your car is a #{year} #{color} {@model}."
  end
end

class MyMotorcycle < Vehicle
  include Motorcycle
  SUNROOF = false

  def to_s
    puts "Your motorcycle is a #{color} #{year} #{model}."
  end
end

puts Vehicle.ancestors
puts MyCar.ancestors
puts MyMotorcycle.ancestors
honda = MyCar.new(2015, 'silver', 'CRV')
honda.speed_up(30)
honda.brake(10)
honda.current_speed
honda.shut_off
honda.color = 'red'
puts honda.color
puts honda.year
honda.spray_paint('blue')
honda.age

#7.Create a class 'Student' with attributes name and grade. Do NOT make the grade getter public, 
#so joe.grade will raise an error. Create a better_grade_than? method

class Student
  def initialize(n, g)
    @name = n
    @grade = g
  end

  def better_grade_than?(person)
    grade > person.grade
  end

  protected

  def grade
    @grade
  end
end

bob = Student.new('bob', 90)
greg = Student.new('greg', 80)
p bob.better_grade_than?(greg)

#8.This code gives a NoMethodError. Why?

bob = Person.new
bob.hi

#There reason there is an error is that the keyword 'private' is above this method, and therefore the method
#is not accessible outside of the class. We can fix it by taking out 'private' or creating a public method
#inside the class that calls the private method from within that class.