class Cat
  def initialize(type)
    @type = type
  end
end

#Change the to_s method to output something like this: I am a tabby cat?

class Cat
  def initialize(type)
    @type = type
  end

  def to_s
    "I am a #{@type} cat."
  end
end

fluffy = Cat.new('tabby')
fluffy.to_s