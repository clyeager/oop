class Television
  def self.manufacturer
    # method logic
  end

  def model
    # method logic
  end
end

tv = Television.new
tv.manufacturer
tv.model

Television.manufacturer
Television.model

#What would happen?

#tv.manufacturer would raise an error because manufacturer is a class method
#tv.model would run correctly
#Television.manufacturer would run correctly
#Television.model would raise an error because model is an instance methodmto be called on objects
