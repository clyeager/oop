class InvoiceEntry
  attr_reader :quantity, :product_name

  def initialize(product_name, number_purchased)
    @quantity = number_purchased
    @product_name = product_name
  end

  def update_quantity(updated_count)
    quantity = updated_count if updated_count >= 0
  end
end

#What is the problem with changing the code to:

class InvoiceEntry
  attr_reader :quantity
  attr_accessor :quantity

  def initialize(product_name, number_purchased)
    @quantity = number_purchased
    @product_name = product_name
  end

  def update_quantity(updated_count)
    self.quantity = updated_count if updated_count >= 0
  end
end

#A potential problem could be the fact that now a user has the means to change the quantity
# outside if the class (and without the update_quantity method) by calling object.quantity = <quantity>