module Taste
  def flavor(flavor)
    puts "#{flavor}"
  end
end

class Orange
  include Taste
end

class HotSauce
  include Taste
end

#how to find where Ruby will look for a method when called, and object's ancestors
#What is the lookup chain for Orange and Hotsauce?


#To find ancestors, we simply call class.ancestors(will follow this path to lookup methods)
#Orange: Orange class, Taste module, Object class, Kernel class, BasicObject class
#Hotsauce: Hotsauce class, Taste module, Object class, Kernel class, BasicObject class