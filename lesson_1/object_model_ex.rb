#1.How do we create an object in Ruby? Give an example of the creation of an object.

#We create an object by instantiating a new instance of a class, which can be done using the .new class method.

#For example:

class Cat
end

butter = Cat.new

#2.What is a module? What is its purpose? How do we use them with our classes? Create a module
# for the class you created in exercise 1 and include it properly.

#A module is a set of behaviors and methods that can be mnixed in to a class, so objects of that class
# can use those methods. We do this by mixins, which means in a class itself, we use the include method 
#to include the module we want to incorporate.

module Purr
  def purr
    puts 'prrr'
  end
end

class Cat
  include Purr
end

butter.purr #=> prrr


