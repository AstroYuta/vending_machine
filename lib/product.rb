class Product
  attr_reader :name, :price
  def initialize(name:, price:)
    @name = name
    @price = price
    if @price.amount < 0
      raise ArgumentError
    end
  end

  def eql?(other)
    @name == other.name && @price == other.price
  end

  def hash
    [name, price.hash].hash
  end
end
