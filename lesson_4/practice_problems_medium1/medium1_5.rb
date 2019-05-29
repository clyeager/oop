class KrispyKreme
  def initialize(filling_type, glazing)
    @filling_type = filling_type
    @glazing = glazing
  end
end

#expected behavior

donut1 = KrispyKreme.new(nil, nil)
donut2 = KrispyKreme.new("Vanilla", nil)
donut3 = KrispyKreme.new(nil, "sugar")
donut4 = KrispyKreme.new(nil, "chocolate sprinkles")
donut5 = KrispyKreme.new("Custard", "icing")

puts donut1
  => "Plain"

puts donut2
  => "Vanilla"

puts donut3
  => "Plain with sugar"

puts donut4
  => "Plain with chocolate sprinkles"

puts donut5
  => "Custard with icing"

#make the class work as needed

class KrispyKreme
  def initialize(filling_type = 'Plain', glazing)
    @filling_type = filling_type if filling_type != nil
    @filling_type = 'Plain' if filling_type == nil
    @glazing = glazing
  end

  def to_s
    return "#{@filling_type} with #{glazing}" if glazing
    "#{@filling_type}"
  end
end