class AngryCat
  def initialize(age, name)
    @age  = age
    @name = name
  end

  def age
    puts @age
  end

  def name
    puts @name
  end

  def hiss
    puts "Hisssss!!!"
  end
end

#Create two instances

fluffy = AngryCat.new('Fluffy', 5)
peanut = AngryCat.new('Peanut', 10)