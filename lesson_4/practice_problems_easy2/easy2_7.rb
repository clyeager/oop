class Cat
  @@cats_count = 0

  def initialize(type)
    @type = type
    @age  = 0
    @@cats_count += 1
  end

  def self.cats_count
    @@cats_count
  end
end

#What does @@cats_count do and what code do you need to test this?

#This class variable keeps track of how many instances of the Cat class are created.

fluffy = Cat.new('calico')
peanut = Cat.new('tabby')

p Cat.cats_count # => 2

