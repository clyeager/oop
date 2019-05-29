class BankAccount
  attr_reader :balance

  def initialize(starting_balance)
    @balance = starting_balance
  end

  def positive_balance?
    balance >= 0
  end
end

#Alyssa thinks Ben is missing the @ on the balance instance variable in the body
# of the positive_balance? method. Who is right?

#Ben is correct because he is referencing the balance getter method, given to him by attr_reader :balance
