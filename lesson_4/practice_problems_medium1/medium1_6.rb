class Computer
  attr_accessor :template

  def create_template
    @template = "template 14231"
  end

  def show_template
    template
  end
end

class Computer
  attr_accessor :template

  def create_template
    self.template = "template 14231"
  end

  def show_template
    self.template
  end
end

#What is the difference in the way the code works?

#In the first example we are directly assigning to the @template instance variable
#In the second, we are calling the setter method self.template given to use by attr_accessor
#and also calling self.template for the getter method, which is unnecessary.
#However, they both produce the same result
