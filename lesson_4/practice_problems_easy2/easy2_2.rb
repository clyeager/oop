class Oracle
  def predict_the_future
    "You will " + choices.sample
  end

  def choices
    ["eat a nice lunch", "take a nap soon", "stay at work late"]
  end
end

class RoadTrip < Oracle
  def choices
    ["visit Vegas", "fly to Fiji", "romp in Rome"]
  end
end

trip = RoadTrip.new
trip.predict_the_future

#what is the result

#This results in "You will " concatenated with a randon sample of the array within the 
#choices method definition of RoadTrip becaue Ruby first looks for a matching method
# in the calling object's class definition