#1.Create a sub-class from Dog called Bulldog overriding the swim method to return "can't swim!"

class Dog
  def speak
    'bark!'
  end

  def swim
    'swimming!'
  end
end

teddy = Dog.new
puts teddy.speak
puts teddy.swim

class Bulldog < Dog
  def swim
    "can't swim!"
  end
end

#2.Create a Cat class that can do everything except swim and fetch.

class Animal
  def run
    'running!'
  end

  def jump
    'jumping!'
  end

  def speak(sound)
    return sound
  end
end

class Dog < Animal
  def speak
    super('bark!')
  end

  def swim
    'swimming!'
  end

  def fetch
    'fetching!'
  end
end

class Cat < Animal
  def speak(sound)
    super(sound)
  end
end

#3.Create a class hierarchy of classes from #2

#          Animal (run, jump)
#         /     \
#       Cat      Dog
#    (speak)    (speak, fetch, swim)
#                 |
#               Bulldog (swim)

#4.What is the method lookup path and how is it implemented?

=begin
The lookup path is the order in which Ruby looks for a method definition to carry out 
behaviors. The order must be correct to implement correctly, and goes as follows:
1.calling object's class
2.last module included in calling object's class, up to the first module in the class
3.superclass directly above the class
4.any modules in that superclass, starting with last module included up to first module
5.Keeps going for all superclasses up to BasicObject
=end
