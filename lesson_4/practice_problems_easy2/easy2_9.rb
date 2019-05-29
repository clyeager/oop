class Game
  def play
    "Start the game!"
  end
end

class Bingo < Game
  def rules_of_play
    #rules of play
  end
end

#What would happen if we added a play method to Bingo class?

#Ruby would first look in the class of the calling object. So if the object was an instance
#of the Bingo class, then it would run the method play in the Bingo class.