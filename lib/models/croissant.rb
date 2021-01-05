class Croissant
  attr_reader :name, :code

  def initialize(attr = {})
    @name = attr[:name]
    @code = attr[:code]
  end

  def packs_amount
    [3, 5, 9]
  end

  def packs
    { 3 => 5.95, 5 => 9.95, 9 => 16.99 }
  end
end
