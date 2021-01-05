class VegemiteScroll
  attr_reader :name, :code

  def initialize(attr = {})
    @name = attr[:name]
    @code = attr[:code]
  end

  def packs_amount
    [3, 5]
  end

  def packs
    { 3 => 6.99, 5 => 8.99 }
  end
end
