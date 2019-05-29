class Oracle
  def predict_the_future
    "You will " + choices.sample
  end

  def choices
    ["eat a nice lunch", "take a nap soon", "stay at work late"]
  end
end

oracle = Oracle.new
oracle.predict_the_future

#what is the result?

#the result is the return of "You will " concatenated with a random sample of
# the return value (array) of choices method