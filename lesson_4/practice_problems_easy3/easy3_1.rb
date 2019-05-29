class Greeting
  def greet(message)
    puts message
  end
end

class Hello < Greeting
  def hi
    greet("Hello")
  end
end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end

#What happens in the following cases:

hello = Hello.new
hello.hi

#outputs "Hello"

hello = Hello.new
hello.bye

#undefined method error

hello = Hello.new
hello.greet

#ArgumentError due to no argument passed in

hello = Hello.new
hello.greet("Goodbye")

#outputs "Goodbye"

Hello.hi

#Error because there is no class method