class Drink

  attr_accessor(:name, :price)

  def initialize(name, type, price)
    @name = name
    @type = type
    @price = price
  end

end
